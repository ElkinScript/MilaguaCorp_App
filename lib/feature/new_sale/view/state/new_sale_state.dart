import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../client/domain/client_model.dart';
import '../../../product/domain/product_model.dart';
import '../../domain/new_sale_model.dart';

part 'new_sale_state.freezed.dart';

@freezed
class NewSaleState with _$NewSaleState {
  const factory NewSaleState.initial() = _Initial;
  const factory NewSaleState.loading() = _Loading;
  const factory NewSaleState.ready({
    required List<ProductModel> products,
    @Default([]) List<PaymentMethodModel> paymentMethods,
    ClientModel? client,
    @Default([]) List<CartItem> cart,
    @Default([]) List<StandaloneContainerItem> standaloneContainers,
    @Default('') String paymentMethod,
    @Default('') String observation,
    // Generado una sola vez al primer intento de confirmar — se reutiliza
    // en reintentos para que la idempotencia del backend sirva de algo
    // (si no, cada reintento sería una venta "distinta" para el servidor).
    String? operationId,
    @Default(false) bool submitting,
    @Default(false) bool success,
    String? submitError,
  }) = _Ready;
  const factory NewSaleState.error(String message) = _Error;
}
