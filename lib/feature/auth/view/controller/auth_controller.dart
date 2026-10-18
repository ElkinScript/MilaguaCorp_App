import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/common/drivers/http/session_events.dart';
import '../../application/auth_usecase.dart';
import '../state/auth_state.dart';

// Sin autoDispose: la sesión es global y el router (redirect) la escucha
// durante toda la vida de la app.
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final controller = AuthController(ref.watch(authUseCaseProvider));
  // Refresh rechazado en la capa HTTP → la sesión ya se limpió del storage,
  // sólo falta reflejarlo en el estado (el router manda a /login).
  final sub = ref
      .watch(sessionEventsProvider)
      .onExpired
      .listen((_) => controller.sessionExpired());
  ref.onDispose(sub.cancel);
  // Auto-login: al arrancar se intenta restaurar la sesión guardada.
  controller.checkAuth();
  return controller;
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._useCase) : super(const AuthState.checking());

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

  /// Restaura la sesión guardada — mientras tanto el estado es `checking`
  /// (splash). Sin sesión válida queda en `initial` (login).
  Future<void> checkAuth() async {
    state = const AuthState.checking();
    final result = await _useCase.checkAuth();
    if (!mounted) return;
    result.fold(
      (error) => state = const AuthState.initial(),
      (user) => state = AuthState.authenticated(user),
    );
  }

  /// La capa HTTP avisó que el refresh token fue rechazado (el storage ya
  /// quedó limpio). Durante el arranque no se toca: checkAuth resuelve solo.
  void sessionExpired() {
    if (!mounted) return;
    state.maybeWhen(
      checking: () {},
      orElse: () => state = const AuthState.initial(),
    );
  }

  /// Actualiza el perfil y refresca el estado en memoria de inmediato —
  /// devuelve el mensaje de error, o null si se guardó correctamente.
  Future<String?> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    File? profilePicture,
  }) async {
    final result = await _useCase.updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePicture: profilePicture,
    );
    return result.fold(
      (error) => error.message,
      (user) {
        state = AuthState.authenticated(user);
        return null;
      },
    );
  }

  /// Cambia la contraseña del usuario autenticado — devuelve el mensaje de
  /// error, o null si se actualizó correctamente.
  Future<String?> changePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    final result = await _useCase.changePassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return result.fold((error) => error.message, (_) => null);
  }
}
