import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/client_model.dart';

part 'client_search_state.freezed.dart';

@freezed
class ClientSearchState with _$ClientSearchState {
  const factory ClientSearchState({
    @Default('') String query,
    @Default(false) bool searching,
    @Default([]) List<ClientModel> results,
    // true una vez que se completó al menos una búsqueda — distingue
    // "todavía no busca nada" de "buscó y no encontró nada".
    @Default(false) bool searched,
    @Default(false) bool showRegisterForm,
    @Default(false) bool registering,
    String? errorMessage,
  }) = _ClientSearchState;
}
