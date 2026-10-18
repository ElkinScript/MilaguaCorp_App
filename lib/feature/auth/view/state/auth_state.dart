import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  /// Arranque de la app: se está restaurando la sesión guardada (se muestra
  /// el splash, ni login ni home todavía).
  const factory AuthState.checking() = _Checking;

  /// Sin sesión (nunca inició, cerró sesión o la sesión expiró).
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserModel user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
