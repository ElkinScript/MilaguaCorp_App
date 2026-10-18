import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milaguacorp/core/constants/app_strings.dart';
import 'package:milaguacorp/core/flavors/flavors_config.dart';
import 'package:milaguacorp/feature/auth/application/auth_usecase.dart';
import 'package:milaguacorp/feature/auth/data/repositories/auth_repository.dart';
import 'package:milaguacorp/feature/auth/domain/user_model.dart';
import 'package:milaguacorp/feature/auth/view/controller/auth_controller.dart';
import 'package:milaguacorp/feature/auth/view/state/auth_state.dart';
import 'package:milaguacorp/modules/app_module.dart';
import 'package:milaguacorp/modules/common/drivers/http/auth_refresh_interceptor.dart';
import 'package:milaguacorp/modules/common/drivers/http/dio_http_client.dart';
import 'package:milaguacorp/modules/common/drivers/http/session_events.dart';
import 'package:milaguacorp/modules/common/drivers/storage/local_storage_impl.dart';
import 'package:milaguacorp/modules/common/exceptions/server_exception.dart';

import '../../helpers/fakes.dart';

const _user = UserModel(id: 1, username: 'ana', firstName: 'Ana');

/// Repo falso: sólo getProfile importa para el arranque.
class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this.profile);

  Either<ServerException, UserModel> profile;
  int getProfileCalls = 0;

  @override
  Future<Either<ServerException, UserModel>> getProfile() async {
    getProfileCalls++;
    return profile;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<AuthState> _settled(ProviderContainer container) async {
  container.read(authControllerProvider);
  for (var i = 0; i < 20; i++) {
    await pumpEventQueue();
    final s = container.read(authControllerProvider);
    if (s.maybeWhen(checking: () => false, orElse: () => true)) return s;
  }
  return container.read(authControllerProvider);
}

bool _isUnauthenticated(AuthState s) =>
    s.maybeWhen(initial: () => true, orElse: () => false);

void main() {
  group('AppModule.authRedirect (decisión de ruta)', () {
    const checking = AuthState.checking();
    const unauth = AuthState.initial();
    const authed = AuthState.authenticated(_user);

    test('restaurando sesión → splash', () {
      expect(AppModule.authRedirect(checking, '/splash'), isNull);
      expect(AppModule.authRedirect(checking, '/login'), '/splash');
      expect(AppModule.authRedirect(checking, '/home'), '/splash');
    });

    test('sesión válida → home (desde splash o login), resto se respeta', () {
      expect(AppModule.authRedirect(authed, '/splash'), '/home');
      expect(AppModule.authRedirect(authed, '/login'), '/home');
      expect(AppModule.authRedirect(authed, '/home'), isNull);
      expect(AppModule.authRedirect(authed, '/sales'), isNull);
    });

    test('sin sesión → login (incluye loading/error del propio login)', () {
      expect(AppModule.authRedirect(unauth, '/splash'), '/login');
      expect(AppModule.authRedirect(unauth, '/home'), '/login');
      expect(AppModule.authRedirect(unauth, '/sales'), '/login');
      expect(AppModule.authRedirect(unauth, '/login'), isNull);
      expect(
        AppModule.authRedirect(const AuthState.loading(), '/login'),
        isNull,
      );
      expect(
        AppModule.authRedirect(const AuthState.error('x'), '/login'),
        isNull,
      );
    });
  });

  group('AuthUseCase.checkAuth', () {
    test('sin tokens guardados → Left y no llama al backend', () async {
      final repo = _FakeAuthRepository(const Right(_user));
      final useCase = AuthUseCase(repo, InMemoryStorage());

      final result = await useCase.checkAuth();

      expect(result.isLeft, isTrue);
      expect(repo.getProfileCalls, 0);
    });

    test('con tokens y /me/ OK → Right y guarda el perfil', () async {
      final storage = InMemoryStorage({
        AppStrings.keyTokenAccess: 'a',
        AppStrings.keyTokenRefresh: 'r',
      });
      final repo = _FakeAuthRepository(const Right(_user));

      final result = await AuthUseCase(repo, storage).checkAuth();

      expect(result.right, _user);
      expect(storage.data['mg_username'], 'ana');
    });

    test('sólo refresh token (access perdido) igual intenta restaurar',
        () async {
      final storage = InMemoryStorage({AppStrings.keyTokenRefresh: 'r'});
      final repo = _FakeAuthRepository(const Right(_user));

      final result = await AuthUseCase(repo, storage).checkAuth();

      expect(result.isRight, isTrue);
      expect(repo.getProfileCalls, 1);
    });
  });

  group('AuthController (arranque)', () {
    ProviderContainer containerWith(
      InMemoryStorage storage,
      _FakeAuthRepository repo,
    ) {
      final c = ProviderContainer(overrides: [
        secureLocalDataSourceProvider.overrideWithValue(storage),
        authRepositoryProvider.overrideWithValue(repo),
      ]);
      addTearDown(c.dispose);
      return c;
    }

    test('empieza en checking y con sesión válida termina authenticated',
        () async {
      final c = containerWith(
        InMemoryStorage({AppStrings.keyTokenAccess: 'a'}),
        _FakeAuthRepository(const Right(_user)),
      );

      expect(
        c.read(authControllerProvider),
        const AuthState.checking(),
      );
      expect(await _settled(c), const AuthState.authenticated(_user));
    });

    test('sin sesión guardada termina initial (login)', () async {
      final c = containerWith(
        InMemoryStorage(),
        _FakeAuthRepository(const Right(_user)),
      );

      expect(_isUnauthenticated(await _settled(c)), isTrue);
    });

    test('/me/ falla → initial (login)', () async {
      final c = containerWith(
        InMemoryStorage({AppStrings.keyTokenAccess: 'a'}),
        _FakeAuthRepository(const Left(ServerException('Tu sesión expiró.'))),
      );

      expect(_isUnauthenticated(await _settled(c)), isTrue);
    });

    test('evento de sesión expirada con sesión activa → initial', () async {
      final c = containerWith(
        InMemoryStorage({AppStrings.keyTokenAccess: 'a'}),
        _FakeAuthRepository(const Right(_user)),
      );
      await _settled(c);

      c.read(sessionEventsProvider).notifyExpired();
      await pumpEventQueue();

      expect(_isUnauthenticated(c.read(authControllerProvider)), isTrue);
    });

    test('logout limpia el storage', () async {
      final storage = InMemoryStorage({
        AppStrings.keyTokenAccess: 'a',
        AppStrings.keyTokenRefresh: 'r',
      });
      final c = containerWith(storage, _FakeAuthRepository(const Right(_user)));
      await _settled(c);

      await c.read(authControllerProvider.notifier).logout();

      expect(storage.data, isEmpty);
      expect(_isUnauthenticated(c.read(authControllerProvider)), isTrue);
    });
  });

  group('arranque de punta a punta (HTTP real con adapter falso)', () {
    late InMemoryStorage storage;

    setUp(() {
      FlavorConfig.instance =
          const FlavorConfig(flavor: 'test', baseUrl: 'http://test.local');
      debugPrint = (String? message, {int? wrapWidth}) {};
      storage = InMemoryStorage({
        AppStrings.keyTokenAccess: 'access-vencido',
        AppStrings.keyTokenRefresh: 'refresh-1',
      });
    });

    tearDown(() => debugPrint = debugPrintThrottled);

    ProviderContainer containerWith(FakeHttpAdapter adapter) {
      final c = ProviderContainer(overrides: [
        secureLocalDataSourceProvider.overrideWithValue(storage),
        dioHttpClientProvider.overrideWith(
          (ref) => DioHttpClient(
            storage,
            sessionEvents: ref.watch(sessionEventsProvider),
            httpClientAdapter: adapter,
          ),
        ),
      ]);
      addTearDown(c.dispose);
      return c;
    }

    test('access vencido + refresh válido → refresca y entra a home',
        () async {
      final adapter = FakeHttpAdapter((o) {
        if (o.uri.path == AuthRefreshInterceptor.refreshPath) {
          return const FakeResponse(
            200,
            {'access': 'access-nuevo', 'refresh': 'refresh-2'},
          );
        }
        return bearerOf(o) == 'access-nuevo'
            ? const FakeResponse(200, {
                'message': 'Usuario autenticado',
                'user': {'id': 1, 'username': 'ana'},
              })
            : const FakeResponse(401, {'detail': 'Token is invalid'});
      });
      final c = containerWith(adapter);

      final state = await _settled(c);

      expect(state.mapOrNull(authenticated: (s) => s.user.username), 'ana');
      expect(AppModule.authRedirect(state, '/splash'), '/home');
      expect(storage.data[AppStrings.keyTokenRefresh], 'refresh-2');
    });

    test('refresh vencido → limpia sesión y va a login', () async {
      final adapter = FakeHttpAdapter((o) =>
          o.uri.path == AuthRefreshInterceptor.refreshPath
              ? const FakeResponse(
                  409, {'message': 'Token is invalid or expired'})
              : const FakeResponse(401, {'detail': 'Token is invalid'}));
      final c = containerWith(adapter);

      final state = await _settled(c);

      expect(_isUnauthenticated(state), isTrue);
      expect(AppModule.authRedirect(state, '/splash'), '/login');
      expect(storage.data, isEmpty);
    });
  });
}
