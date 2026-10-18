// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../product/domain/product_model.dart';

part 'new_sale_model.freezed.dart';
part 'new_sale_model.g.dart';

// Línea de carrito — un producto (retornable o no).
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int productId,
    required String productName,
    required String unitPrice,
    @Default(1) int quantity,
    @Default('') String productType,
    @Default(false) bool isReturnable,
    ReturnableContainerModel? returnableContainer,
    // Cuántos envases del tipo requerido entrega el cliente en esta línea
    // (intercambio) — Django recalcula "pomas nuevas" = quantity - esto,
    // nunca se le manda un número de pomas nuevas ya calculado (regla:
    // todos los totales se recalculan en el backend).
    @Default(0) int returnedContainerQuantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

extension CartItemX on CartItem {
  double get unitPriceValue => double.tryParse(unitPrice) ?? 0;
  double get productSubtotal => unitPriceValue * quantity;

  int get newContainerQuantity =>
      isReturnable ? (quantity - returnedContainerQuantity).clamp(0, quantity) : 0;

  double get containerUnitPrice => returnableContainer?.priceValue ?? 0;
  double get containerSubtotal => newContainerQuantity * containerUnitPrice;

  /// Total de la línea: producto + pomas nuevas cobradas (las devueltas son
  /// intercambio, van a $0 — ver doc Empleado V1, sección 8, Modo A).
  double get lineTotal => productSubtotal + containerSubtotal;
}

// Línea de envase suelto — "poma sola", sin producto asociado (doc sección
// 8, Modo C). Descuenta directo de ContainerStock en el backend.
@freezed
class StandaloneContainerItem with _$StandaloneContainerItem {
  const factory StandaloneContainerItem({
    required int containerTypeId,
    required String containerTypeName,
    required String unitPrice,
    @Default(1) int quantity,
  }) = _StandaloneContainerItem;

  factory StandaloneContainerItem.fromJson(Map<String, dynamic> json) =>
      _$StandaloneContainerItemFromJson(json);
}

extension StandaloneContainerItemX on StandaloneContainerItem {
  double get unitPriceValue => double.tryParse(unitPrice) ?? 0;
  double get subtotal => unitPriceValue * quantity;
}

// Payload real de POST /api/sale/create/ — ver
// core/sale/api/v1/sale/serializers/sale.py (SaleCreateSerializer, Fase 3).
// client_id y operation_id son obligatorios; branch NO existe aquí a
// propósito — el backend la deriva siempre del empleado autenticado.
@freezed
class NewSaleRequest with _$NewSaleRequest {
  const factory NewSaleRequest({
    required String operationId,
    required int clientId,
    required String paymentMethod,
    @Default('') String observation,
    @Default([]) List<CartItem> items,
    @Default([]) List<StandaloneContainerItem> standaloneContainers,
  }) = _NewSaleRequest;
}

extension NewSaleRequestX on NewSaleRequest {
  Map<String, dynamic> toRequestJson() => {
        'operation_id': operationId,
        'client_id': clientId,
        'payment_method': paymentMethod,
        'observation': observation,
        'items': items
            .map((i) => {
                  'product_id': i.productId,
                  'quantity': i.quantity,
                  'returned_container_quantity':
                      i.isReturnable ? i.returnedContainerQuantity : 0,
                })
            .toList(),
        'standalone_containers': standaloneContainers
            .map((c) => {
                  'container_type_id': c.containerTypeId,
                  'quantity': c.quantity,
                })
            .toList(),
      };
}

// Método de pago — viene de Administración > Datos Dinámicos, no está fijo
// en la app (así se puede agregar uno nuevo sin actualizar el APK).
@freezed
class PaymentMethodModel with _$PaymentMethodModel {
  const factory PaymentMethodModel({
    required String value,
    required String label,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}
