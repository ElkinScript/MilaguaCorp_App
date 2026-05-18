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
    @Default(true) bool state,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
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
