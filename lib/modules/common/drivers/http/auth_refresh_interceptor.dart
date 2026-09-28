import 'package:dio/dio.dart';

import '../../../../core/constants/app_strings.dart';
import '../storage/local_storage.dart';

/// Refresh transparente del access token (SimpleJWT).
///
/// Cuando un endpoint (que no sea de auth) responde 401:
///   1. Llama UNA sola vez a `POST /api/auth/token/refresh/` — si llegan varios
///      401 a la vez, todos esperan el mismo Future en vuelo (no hay refresh
///      en paralelo).
///   2. Guarda el access nuevo y, como el backend tiene
///      `ROTATE_REFRESH_TOKENS=True`, también el refresh rotado.
///   3. Reintenta el request original con el MISMO body (ej. la venta viaja
///      con su `operation_id` idempotente, así que reintentarla es seguro).
///
/// Si el refresh es rechazado por el backend (token vencido/ inválido) se
/// limpia la sesión y se avisa por [onSessionExpired] para mandar a /login.
/// Si el refresh falla por red/timeout/5xx NO se limpia la sesión: se
/// devuelve el error original y el usuario puede reintentar.
///
/// Nunca entra en bucle: los endpoints `/api/auth/token/*` se ignoran y un
/// request ya reintentado que vuelve a dar 401 no dispara otro refresh.
class AuthRefreshInterceptor extends Interceptor {
  AuthRefreshInterceptor({
    required Dio dio,
    required Dio refreshDio,
    required LocalStorage storage,
    required Future<void> Function() onSessionExpired,
  })  : _dio = dio,
        _refreshDio = refreshDio,
        _storage = storage,
        _onSessionExpired = onSessionExpired;

  static const refreshPath = '/api/auth/token/refresh/';

  /// Prefijo de los endpoints de token (login, refresh, verify) — un 401/409
  /// de estos nunca debe disparar un refresh.
  static const _authTokenPrefix = '/api/auth/token/';

  /// Marca en `RequestOptions.extra` de un request que ya fue reintentado.
  static const retriedKey = 'mg_auth_retried';

  final Dio _dio;
  final Dio _refreshDio;
  final LocalStorage _storage;
  final Future<void> Function() _onSessionExpired;

  /// Refresh en vuelo — compartido por todos los 401 concurrentes.
  Future<bool>? _refreshing;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 401 || _isAuthTokenRequest(options)) {
      return handler.next(err);
    }

    // Ya se reintentó con un token recién emitido y aun así 401 (ej. usuario
    // desactivado): la sesión no sirve, no volver a refrescar.
    if (options.extra[retriedKey] == true) {
      await _expireSession();
      return handler.next(err);
    }

    final refreshed = await _refreshIfNeeded(_bearerOf(options));
    if (!refreshed) return handler.next(err);

    try {
      final retry = options.copyWith(
        data: _cloneData(options.data),
        // El header Authorization lo vuelve a poner el interceptor de auth
        // leyendo el token nuevo del storage.
        headers: {...options.headers}..remove('Authorization'),
        extra: {...options.extra, retriedKey: true},
      );
      final response = await _dio.fetch<dynamic>(retry);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }

  /// Devuelve true si hay un access token nuevo con el cual reintentar.
  Future<bool> _refreshIfNeeded(String? usedToken) async {
    final inFlight = _refreshing;
    if (inFlight != null) return inFlight;

    final current = await _storage.getItem(AppStrings.keyTokenAccess);

    // Mientras se leía el storage otro 401 pudo haber arrancado el refresh.
    final started = _refreshing;
    if (started != null) return started;

    // Otro request ya refrescó después de que éste salió con el token viejo:
    // basta con reintentar con el token actual.
    if (current != null && current != usedToken) return true;

    final future = _doRefresh();
    _refreshing = future;
    try {
      return await future;
    } finally {
      _refreshing = null;
    }
  }

  Future<bool> _doRefresh() async {
    final refresh = await _storage.getItem(AppStrings.keyTokenRefresh);
    if (refresh == null || refresh.isEmpty) {
      await _expireSession();
      return false;
    }

    try {
      final response = await _refreshDio.post<dynamic>(
        refreshPath,
        data: {'refresh': refresh},
      );
      final data = response.data;
      final access = data is Map ? data['access'] : null;
      if (access is! String || access.isEmpty) return false;

      await _storage.setItem(AppStrings.keyTokenAccess, access);
      final rotated = data['refresh'];
      if (rotated is String && rotated.isNotEmpty) {
        await _storage.setItem(AppStrings.keyTokenRefresh, rotated);
      }
      return true;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      // 4xx = el backend rechazó el refresh token (SimpleJWT responde 401,
      // pero el wrapper save_error_api del backend lo convierte en 409).
      if (status != null && status >= 400 && status < 500) {
        await _expireSession();
      }
      return false;
    }
  }

  Future<void> _expireSession() async {
    await _storage.removeAll();
    await _onSessionExpired();
  }

  bool _isAuthTokenRequest(RequestOptions options) =>
      options.uri.path.contains(_authTokenPrefix) ||
      options.path.contains(_authTokenPrefix);

  String? _bearerOf(RequestOptions options) {
    final header = options.headers['Authorization'];
    if (header is! String || !header.startsWith('Bearer ')) return null;
    return header.substring('Bearer '.length);
  }

  /// Un FormData ya enviado queda "finalized" y Dio no deja reenviarlo —
  /// se clona (incluye los MultipartFile) para el reintento.
  Object? _cloneData(Object? data) => data is FormData ? data.clone() : data;
}
