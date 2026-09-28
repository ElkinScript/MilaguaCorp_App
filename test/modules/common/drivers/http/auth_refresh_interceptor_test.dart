import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milaguacorp/core/constants/app_strings.dart';
import 'package:milaguacorp/core/flavors/flavors_config.dart';
import 'package:milaguacorp/modules/common/drivers/http/auth_refresh_interceptor.dart';
import 'package:milaguacorp/modules/common/drivers/http/dio_http_client.dart';
import 'package:milaguacorp/modules/common/drivers/http/session_events.dart';

import '../../../../helpers/fakes.dart';

const _refreshPath = AuthRefreshInterceptor.refreshPath;

void main() {
  late InMemoryStorage storage;
  late SessionEvents sessionEvents;
  late int expiredEvents;
  late StreamSubscription<void> sub;

  setUp(() {
    FlavorConfig.instance =
        const FlavorConfig(flavor: 'test', baseUrl: 'http://test.local');
    // Silencia el _PrettyLogInterceptor (kDebugMode es true en tests).
    debugPrint = (String? message, {int? wrapWidth}) {};
    storage = InMemoryStorage({
      AppStrings.keyTokenAccess: 'access-viejo',
      AppStrings.keyTokenRefresh: 'refresh-1',
      'mg_username': 'ana',
    });
    sessionEvents = SessionEvents();
    expiredEvents = 0;
    sub = sessionEvents.onExpired.listen((_) => expiredEvents++);
  });

  tearDown(() async {
    await sub.cancel();
    sessionEvents.dispose();
    debugPrint = debugPrintThrottled;
  });

  Dio buildDio(FakeHttpAdapter adapter) => DioHttpClient(
        storage,
        sessionEvents: sessionEvents,
        httpClientAdapter: adapter,
      )();

  /// Backend que acepta sólo `access-nuevo` y refresca OK (rotando refresh).
  FakeResponse happyBackend(RequestOptions o) {
    if (o.uri.path == _refreshPath) {
      return const FakeResponse(
        200,
        {'access': 'access-nuevo', 'refresh': 'refresh-2'},
      );
    }
    return bearerOf(o) == 'access-nuevo'
        ? const FakeResponse(200, {'ok': true})
        : const FakeResponse(
            401,
            {'detail': 'Given token not valid for any token type'},
          );
  }

  group('refresh y reintento', () {
    test('401 → refresca una vez, guarda tokens rotados y reintenta', () async {
      final adapter = FakeHttpAdapter(happyBackend);
      final dio = buildDio(adapter);

      final res = await dio.get<dynamic>('/api/sale/list/');

      expect(res.statusCode, 200);
      expect(res.data, {'ok': true});
      expect(adapter.requestsTo(_refreshPath), hasLength(1));
      expect(
        adapter.requestsTo(_refreshPath).single.data,
        {'refresh': 'refresh-1'},
      );
      final sales = adapter.requestsTo('/api/sale/list/');
      expect(sales.map(bearerOf), ['access-viejo', 'access-nuevo']);
      expect(storage.data[AppStrings.keyTokenAccess], 'access-nuevo');
      expect(storage.data[AppStrings.keyTokenRefresh], 'refresh-2');
      expect(expiredEvents, 0);
    });

    test('reintenta POST /api/sale/create/ con el MISMO body (operation_id)',
        () async {
      final adapter = FakeHttpAdapter(happyBackend);
      final dio = buildDio(adapter);
      final body = {
        'operation_id': '6f1c7c1e-0000-4000-8000-000000000001',
        'client_id': 7,
        'items': [
          {'product_id': 1, 'quantity': 2},
        ],
      };

      final res = await dio.post<dynamic>('/api/sale/create/', data: body);

      expect(res.statusCode, 200);
      final creates = adapter.requestsTo('/api/sale/create/');
      expect(creates, hasLength(2));
      expect(creates[0].data, body);
      expect(creates[1].data, body);
      expect(creates[1].method, 'POST');
    });

    test('si el refresh no rota el refresh token se conserva el anterior',
        () async {
      final adapter = FakeHttpAdapter((o) => o.uri.path == _refreshPath
          ? const FakeResponse(200, {'access': 'access-nuevo'})
          : happyBackend(o));
      final dio = buildDio(adapter);

      await dio.get<dynamic>('/api/auth/me/');

      expect(storage.data[AppStrings.keyTokenAccess], 'access-nuevo');
      expect(storage.data[AppStrings.keyTokenRefresh], 'refresh-1');
    });
  });

  group('concurrencia', () {
    test('varios 401 simultáneos → un solo refresh y todos se reintentan',
        () async {
      final refreshGate = Completer<void>();
      final adapter = FakeHttpAdapter((o) async {
        if (o.uri.path == _refreshPath) {
          await refreshGate.future; // refresh "lento" en vuelo
        }
        return happyBackend(o);
      });
      final dio = buildDio(adapter);

      final futures = [
        dio.get<dynamic>('/api/sale/list/'),
        dio.get<dynamic>('/api/product/list/'),
        dio.get<dynamic>('/api/report/summary/'),
        dio.post<dynamic>('/api/sale/create/', data: {'operation_id': 'x'}),
      ];
      // Deja que los 4 requests reciban su 401 y queden esperando el refresh.
      await pumpEventQueue();
      expect(adapter.requestsTo(_refreshPath), hasLength(1));

      refreshGate.complete();
      final responses = await Future.wait(futures);

      expect(responses.map((r) => r.statusCode), everyElement(200));
      expect(adapter.requestsTo(_refreshPath), hasLength(1));
      expect(storage.data[AppStrings.keyTokenAccess], 'access-nuevo');
    });

    test('un 401 que llega después de un refresh ya completado no refresca de '
        'nuevo: reintenta con el token actual', () async {
      final lateGate = Completer<void>();
      final adapter = FakeHttpAdapter((o) async {
        if (o.uri.path == '/api/lento/' && bearerOf(o) == 'access-viejo') {
          await lateGate.future; // salió con el token viejo, responde tarde
        }
        return happyBackend(o);
      });
      final dio = buildDio(adapter);

      final slow = dio.get<dynamic>('/api/lento/');
      await pumpEventQueue();
      await dio.get<dynamic>('/api/rapido/'); // dispara y termina el refresh
      lateGate.complete();
      final res = await slow;

      expect(res.statusCode, 200);
      expect(adapter.requestsTo(_refreshPath), hasLength(1));
    });
  });

  group('refresh fallido', () {
    for (final status in [401, 409]) {
      test('refresh rechazado ($status) → limpia sesión y avisa expiración',
          () async {
        final adapter = FakeHttpAdapter((o) => o.uri.path == _refreshPath
            ? FakeResponse(status, {'message': 'Token is invalid or expired'})
            : const FakeResponse(401, {'detail': 'Token is invalid'}));
        final dio = buildDio(adapter);

        await expectLater(
          dio.get<dynamic>('/api/sale/list/'),
          throwsA(isA<DioException>()
              .having((e) => e.response?.statusCode, 'status', 401)),
        );
        await pumpEventQueue();

        expect(storage.data, isEmpty);
        expect(expiredEvents, 1);
        expect(adapter.requestsTo(_refreshPath), hasLength(1));
        expect(adapter.requestsTo('/api/sale/list/'), hasLength(1));
      });
    }

    test('concurrentes con refresh rechazado → un solo refresh y una sola '
        'expiración', () async {
      final adapter = FakeHttpAdapter((o) => o.uri.path == _refreshPath
          ? const FakeResponse(401, {'detail': 'Token is invalid or expired'})
          : const FakeResponse(401, {'detail': 'Token is invalid'}));
      final dio = buildDio(adapter);

      final results = await Future.wait([
        dio.get<dynamic>('/a/').then((_) => 'ok', onError: (_) => 'error'),
        dio.get<dynamic>('/b/').then((_) => 'ok', onError: (_) => 'error'),
        dio.get<dynamic>('/c/').then((_) => 'ok', onError: (_) => 'error'),
      ]);
      await pumpEventQueue();

      expect(results, everyElement('error'));
      expect(adapter.requestsTo(_refreshPath), hasLength(1));
      expect(expiredEvents, 1);
      expect(storage.data, isEmpty);
    });

    test('error de red en el refresh → NO limpia la sesión', () async {
      final adapter = FakeHttpAdapter((o) {
        if (o.uri.path == _refreshPath) {
          throw DioException.connectionError(
            requestOptions: o,
            reason: 'sin red',
          );
        }
        return const FakeResponse(401, {'detail': 'Token is invalid'});
      });
      final dio = buildDio(adapter);

      await expectLater(
        dio.get<dynamic>('/api/sale/list/'),
        throwsA(isA<DioException>()),
      );
      await pumpEventQueue();

      expect(storage.data[AppStrings.keyTokenAccess], 'access-viejo');
      expect(storage.data[AppStrings.keyTokenRefresh], 'refresh-1');
      expect(expiredEvents, 0);
    });

    test('sin refresh token guardado → expira sin llamar al refresh', () async {
      storage.data.remove(AppStrings.keyTokenRefresh);
      final adapter = FakeHttpAdapter(happyBackend);
      final dio = buildDio(adapter);

      await expectLater(
        dio.get<dynamic>('/api/sale/list/'),
        throwsA(isA<DioException>()),
      );
      await pumpEventQueue();

      expect(adapter.requestsTo(_refreshPath), isEmpty);
      expect(storage.data, isEmpty);
      expect(expiredEvents, 1);
    });
  });

  group('sin bucles', () {
    test('un 401 de un endpoint /api/auth/token/* no dispara refresh',
        () async {
      final adapter = FakeHttpAdapter(
        (o) => const FakeResponse(401, {'detail': 'No active account'}),
      );
      final dio = buildDio(adapter);

      await expectLater(
        dio.post<dynamic>('/api/auth/token/', data: {'username': 'x'}),
        throwsA(isA<DioException>()),
      );
      await expectLater(
        dio.post<dynamic>(_refreshPath, data: {'refresh': 'r'}),
        throwsA(isA<DioException>()),
      );

      expect(adapter.requests, hasLength(2)); // sólo los 2 originales
      expect(storage.data[AppStrings.keyTokenAccess], 'access-viejo');
      expect(expiredEvents, 0);
    });

    test('401 otra vez tras el reintento → no refresca de nuevo y expira',
        () async {
      final adapter = FakeHttpAdapter((o) => o.uri.path == _refreshPath
          ? const FakeResponse(200, {'access': 'access-nuevo'})
          : const FakeResponse(401, {'detail': 'User is inactive'}));
      final dio = buildDio(adapter);

      await expectLater(
        dio.get<dynamic>('/api/auth/me/'),
        throwsA(isA<DioException>()),
      );
      await pumpEventQueue();

      expect(adapter.requestsTo(_refreshPath), hasLength(1));
      expect(adapter.requestsTo('/api/auth/me/'), hasLength(2));
      expect(storage.data, isEmpty);
      expect(expiredEvents, 1);
    });

    test('errores que no son 401 pasan sin tocar la sesión', () async {
      final adapter =
          FakeHttpAdapter((o) => const FakeResponse(500, {'detail': 'boom'}));
      final dio = buildDio(adapter);

      await expectLater(
        dio.get<dynamic>('/api/sale/list/'),
        throwsA(isA<DioException>()
            .having((e) => e.response?.statusCode, 'status', 500)),
      );

      expect(adapter.requests, hasLength(1));
      expect(storage.data[AppStrings.keyTokenAccess], 'access-viejo');
    });
  });
}
