import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/client_usecase.dart';
import '../../domain/client_model.dart';
import '../state/client_search_state.dart';

final clientSearchControllerProvider = StateNotifierProvider.autoDispose<
    ClientSearchController, ClientSearchState>(
  (ref) => ClientSearchController(ref.watch(clientUseCaseProvider)),
);

class ClientSearchController extends StateNotifier<ClientSearchState> {
  ClientSearchController(this._useCase) : super(const ClientSearchState());

  final ClientUseCase _useCase;
  Timer? _debounce;

  static const _minQueryLength = 3;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  /// Se llama en cada tecla — hace debounce para no golpear el servidor en
  /// cada carácter. Búsquedas cortas (<3) no disparan nada: evita traer
  /// medio directorio de clientes con una sola letra.
  void onQueryChanged(String value) {
    state = state.copyWith(query: value, showRegisterForm: false, errorMessage: null);
    _debounce?.cancel();
    final trimmed = value.trim();
    if (trimmed.length < _minQueryLength) {
      state = state.copyWith(results: const [], searched: false);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 450), () => search(trimmed));
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.length < _minQueryLength) return;
    state = state.copyWith(searching: true, errorMessage: null);
    final result = await _useCase.search(trimmed);
    result.fold(
      (err) => state = state.copyWith(
          searching: false, searched: true, errorMessage: err.message),
      (list) => state = state.copyWith(
          searching: false, searched: true, results: list),
    );
  }

  void openRegisterForm() =>
      state = state.copyWith(showRegisterForm: true, errorMessage: null);

  void closeRegisterForm() =>
      state = state.copyWith(showRegisterForm: false, errorMessage: null);

  /// Devuelve el cliente creado si tuvo éxito, o null si falló (el error
  /// queda en errorMessage para que la UI lo muestre).
  Future<ClientModel?> register(NewClientInput input) async {
    state = state.copyWith(registering: true, errorMessage: null);
    final result = await _useCase.register(input);
    return result.fold(
      (err) {
        state = state.copyWith(registering: false, errorMessage: err.message);
        return null;
      },
      (client) {
        state = state.copyWith(registering: false, showRegisterForm: false);
        return client;
      },
    );
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}
