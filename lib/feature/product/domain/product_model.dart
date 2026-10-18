// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    @Default('') String name,
    @Default('') String description,
    @JsonKey(name: 'product_type') ProductTypeModel? productType,
    @JsonKey(name: 'active_price') String? activePrice,
    @JsonKey(name: 'stock_quantity') @Default(0) int stockQuantity,
    // Envase que este producto requiere si es retornable — null si no lo es.
    // Ver core.product.api.v1.product.serializers.product.ProductSerializer.
    @JsonKey(name: 'returnable_container')
    ReturnableContainerModel? returnableContainer,
    @Default(true) bool state,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  bool get isReturnable => productType?.isReturnable ?? false;
  double get priceValue => double.tryParse(activePrice ?? '') ?? 0;
}

@freezed
class ProductTypeModel with _$ProductTypeModel {
  const factory ProductTypeModel({
    @Default(0) int id,
    @Default('') String name,
    @JsonKey(name: 'is_returnable') @Default(false) bool isReturnable,
  }) = _ProductTypeModel;

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeModelFromJson(json);
}

// Envase retornable requerido por un producto (ej. AGUA AZUL -> POMA AZUL).
// Viene anidado en ProductModel.returnableContainer — mismo shape que usa
// ContainerType.to_json_api() en el backend: {id, name, code, price}.
@freezed
class ReturnableContainerModel with _$ReturnableContainerModel {
  const factory ReturnableContainerModel({
    required int id,
    @Default('') String name,
    @Default('') String code,
    String? price,
  }) = _ReturnableContainerModel;

  factory ReturnableContainerModel.fromJson(Map<String, dynamic> json) =>
      _$ReturnableContainerModelFromJson(json);
}

extension ReturnableContainerModelX on ReturnableContainerModel {
  double get priceValue => double.tryParse(price ?? '') ?? 0;
}
