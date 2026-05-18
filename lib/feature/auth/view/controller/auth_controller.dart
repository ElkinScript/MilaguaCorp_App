import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_usecase.dart';
import '../state/auth_state.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) => AuthController(ref.watch(authUseCaseProvider)),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._useCase) : super(const AuthState.initial());

  final AuthUseCase _useCase;

  Future<void> login(String username, String password) async {
    state = const AuthState.loading();
    final result = await _useCase.login(username, password);
    result.fold(
      (error) => state = AuthState.error(error.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    await _useCase.logout();
    state = const AuthState.initial();
  }

  Future<void> checkAuth() async {
    state = const AuthState.loading();
    final result = await _useCase.checkAuth();
    result.fold(
      (error) => state = const AuthState.initial(),
      (user) => state = AuthState.authenticated(user),
    );
  }
}
