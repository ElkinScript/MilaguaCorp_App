import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/flavors/flavors_config.dart';
import '../storage/local_storage.dart';
import '../storage/local_storage_impl.dart';
import 'auth_refresh_interceptor.dart';
import 'session_events.dart';

final dioHttpClientProvider = Provider<DioHttpClient>(
  (ref) {
    final localDataSource = ref.watch(secureLocalDataSourceProvider);
    final sessionEvents = ref.watch(sessionEventsProvider);
    return DioHttpClient(localDataSource, sessionEvents: sessionEvents);
  },
);

class DioHttpClient {
  DioHttpClient(
    this.localDataSource, {
    this.sessionEvents,
    this.httpClientAdapter,
  });

  final LocalStorage localDataSource;

  /// Por aquí se avisa que la sesión expiró (refresh rechazado) para que el
  /// AuthController pase a no autenticado y el router mande a /login.
  final SessionEvents? sessionEvents;

  /// Sólo para tests: reemplaza la capa de red real de Dio.
  final HttpClientAdapter? httpClientAdapter;

  Dio? _dio;

  /// Singleton Dio — interceptors y headers se configuran una sola vez.
  Dio call() => _dio ??= _createDio();

  Dio _baseDio() {
    final dio = Dio()
      ..options.baseUrl = FlavorConfig.instance.baseUrl
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);
    final adapter = httpClientAdapter;
    if (adapter != null) dio.httpClientAdapter = adapter;
    return dio;
  }

  /// Dio "pelado" sólo para `POST /api/auth/token/refresh/` — sin el
  /// interceptor de refresh, así un 401 del propio refresh nunca entra en
  /// bucle.
  Dio _createRefreshDio() {
    final dio = _baseDio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['app-source'] = 'milaguacorp-app';
    if (kDebugMode) dio.interceptors.add(_PrettyLogInterceptor());
    return dio;
  }

  Dio _createDio() {
    final dio = _baseDio();

    // ── Interceptor de autenticación + headers comunes ──────────
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await localDataSource.getItem(AppStrings.keyTokenAccess);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          // No forzar JSON en requests multipart (ej. subida de foto de
          // perfil) — Dio ya pone el boundary correcto para FormData.
          if (options.data is! FormData) {
            options.headers['Content-Type'] = 'application/json';
          }
          options.headers['app-source'] = 'milaguacorp-app';
          options.baseUrl = FlavorConfig.instance.baseUrl;
          return handler.next(options);
        },
      ),
    );

    // ── Interceptor de logging (sólo en debug) ──────────────────
    // Imprime cada request / response / error con formato bonito
    // exactamente como hace Hey Support en su terminal.
    if (kDebugMode) {
      dio.interceptors.add(_PrettyLogInterceptor());
    }

    // ── Interceptor de refresh de token (va al final para que el log
    // muestre el 401 original antes del refresh + reintento) ────────
    dio.interceptors.add(
      AuthRefreshInterceptor(
        dio: dio,
        refreshDio: _createRefreshDio(),
        storage: localDataSource,
        onSessionExpired: () async => sessionEvents?.notifyExpired(),
      ),
    );

    return dio;
  }
}

/// Interceptor de logs estilo Support.
/// Imprime: método, URL, headers, body, status code y data.
class _PrettyLogInterceptor extends Interceptor {
  static const _bar = '────────────────────────────────────────';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint('➡️  REQUEST  ${options.method}  ${options.uri}');
    if (options.headers.isNotEmpty) {
      debugPrint('   Headers: ${_pretty(options.headers)}');
    }
    if (options.data != null) {
      debugPrint('   Body:    ${_pretty(options.data)}');
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint('   Query:   ${_pretty(options.queryParameters)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint(
        '✅ RESPONSE ${response.statusCode}  ${response.requestOptions.method}  ${response.requestOptions.uri}');
    if (response.data != null) {
      debugPrint('   Data:    ${_pretty(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint(
        '❌ ERROR    ${err.response?.statusCode ?? '---'}  ${err.requestOptions.method}  ${err.requestOptions.uri}');
    debugPrint('   Type:    ${err.type}');
    debugPrint('   Message: ${err.message}');
    if (err.response?.data != null) {
      debugPrint('   Body:    ${_pretty(err.response?.data)}');
    }
    handler.next(err);
  }

  String _pretty(Object? data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
