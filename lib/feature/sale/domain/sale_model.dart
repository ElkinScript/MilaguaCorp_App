// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_model.freezed.dart';
part 'sale_model.g.dart';

@freezed
class SaleModel with _$SaleModel {
  const factory SaleModel({
    required int id,
    @JsonKey(name: 'sale_date') @Default('') String saleDate,
    @JsonKey(name: 'employee_name') @Default('') String employeeName,
    @JsonKey(name: 'branch_name') @Default('') String branchName,
    @JsonKey(name: 'payment_method_display') @Default('') String paymentMethodDisplay,
    @Default('0.00') String total,
    @Default('') String observation,
    @Default(true) bool state,
    @Default(null) SaleClientModel? client,
    @Default([]) List<SaleDetailModel> details,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
}

@freezed
class SaleClientModel with _$SaleClientModel {
  const factory SaleClientModel({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
  }) = _SaleClientModel;

  factory SaleClientModel.fromJson(Map<String, dynamic> json) =>
      _$SaleClientModelFromJson(json);
}

@freezed
class SaleDetailModel with _$SaleDetailModel {
  const factory SaleDetailModel({
    @Default(0) int id,
    @JsonKey(name: 'product_name') @Default('') String productName,
    @JsonKey(name: 'product_type') @Default('') String productType,
    @Default(0) int quantity,
    @JsonKey(name: 'unit_price') @Default('0.00') String unitPrice,
    @Default('0.00') String subtotal,
  }) = _SaleDetailModel;

  factory SaleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailModelFromJson(json);
}
