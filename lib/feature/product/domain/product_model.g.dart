// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      productType: json['product_type'] == null
          ? null
          : ProductTypeModel.fromJson(
              json['product_type'] as Map<String, dynamic>),
      activePrice: json['active_price'] as String?,
      priceRecarga: json['price_recarga'] as String?,
      priceNuevo: json['price_nuevo'] as String?,
      stockQuantity: (json['stock_quantity'] as num?)?.toInt() ?? 0,
      state: json['state'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'product_type': instance.productType,
      'active_price': instance.activePrice,
      'price_recarga': instance.priceRecarga,
      'price_nuevo': instance.priceNuevo,
      'stock_quantity': instance.stockQuantity,
      'state': instance.state,
    };

_$ProductTypeModelImpl _$$ProductTypeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductTypeModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      isReturnable: json['is_returnable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductTypeModelImplToJson(
        _$ProductTypeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_returnable': instance.isReturnable,
    };
