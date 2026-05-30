// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_sale_model.freezed.dart';
part 'new_sale_model.g.dart';

// Cart item
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int productId,
    required String productName,
    required String unitPrice,
    @Default(1) int quantity,
    @Default('') String productType,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

extension CartItemX on CartItem {
  double get subtotal => (double.tryParse(unitPrice) ?? 0) * quantity;
  String get subtotalFormatted => subtotal.toStringAsFixed(2);
}

// New sale request body
@freezed
class NewSaleRequest with _$NewSaleRequest {
  const factory NewSaleRequest({
    @JsonKey(name: 'branch') required int branchId,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @Default('') String observation,
    @Default(null) NewSaleClient? client,
    @Default([]) List<NewSaleItem> items,
  }) = _NewSaleRequest;

  factory NewSaleRequest.fromJson(Map<String, dynamic> json) =>
      _$NewSaleRequestFromJson(json);
}

extension NewSaleRequestX on NewSaleRequest {
  Map<String, dynamic> toRequestJson() => {
        'branch': branchId,
        'payment_method': paymentMethod,
        'observation': observation,
        if (client != null)
          'client': {
            'name': client!.name,
            'phone': client!.phone,
            'email': client!.email,
            'has_container': client!.hasContainer,
          },
        'items': items
            .map((i) => {'product': i.productId, 'quantity': i.quantity})
            .toList(),
      };
}

@freezed
class NewSaleClient with _$NewSaleClient {
  const factory NewSaleClient({
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    @JsonKey(name: 'has_container') @Default(true) bool hasContainer,
  }) = _NewSaleClient;

  factory NewSaleClient.fromJson(Map<String, dynamic> json) =>
      _$NewSaleClientFromJson(json);
}

@freezed
class NewSaleItem with _$NewSaleItem {
  const factory NewSaleItem({
    required int productId,
    @Default(1) int quantity,
  }) = _NewSaleItem;

  factory NewSaleItem.fromJson(Map<String, dynamic> json) =>
      _$NewSaleItemFromJson(json);
}

// Branch model for selector
@freezed
class BranchModel with _$BranchModel {
  const factory BranchModel({
    required int id,
    required String name,
  }) = _BranchModel;

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}
