// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleModelImpl _$$SaleModelImplFromJson(Map<String, dynamic> json) =>
    _$SaleModelImpl(
      id: (json['id'] as num).toInt(),
      saleDate: json['sale_date'] as String? ?? '',
      employeeName: json['employee_name'] as String? ?? '',
      branchName: json['branch_name'] as String? ?? '',
      paymentMethodDisplay: json['payment_method_display'] as String? ?? '',
      total: json['total'] as String? ?? '0.00',
      observation: json['observation'] as String? ?? '',
      state: json['state'] as bool? ?? true,
      client: json['client'] == null
          ? null
          : SaleClientModel.fromJson(json['client'] as Map<String, dynamic>),
      details: (json['details'] as List<dynamic>?)
              ?.map((e) => SaleDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SaleModelImplToJson(_$SaleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sale_date': instance.saleDate,
      'employee_name': instance.employeeName,
      'branch_name': instance.branchName,
      'payment_method_display': instance.paymentMethodDisplay,
      'total': instance.total,
      'observation': instance.observation,
      'state': instance.state,
      'client': instance.client,
      'details': instance.details,
    };

_$SaleClientModelImpl _$$SaleClientModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaleClientModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$$SaleClientModelImplToJson(
        _$SaleClientModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
    };

_$SaleDetailModelImpl _$$SaleDetailModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaleDetailModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productName: json['product_name'] as String? ?? '',
      productType: json['product_type'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: json['unit_price'] as String? ?? '0.00',
      subtotal: json['subtotal'] as String? ?? '0.00',
    );

Map<String, dynamic> _$$SaleDetailModelImplToJson(
        _$SaleDetailModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_type': instance.productType,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'subtotal': instance.subtotal,
    };
