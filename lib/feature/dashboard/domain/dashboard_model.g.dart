// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardModelImpl _$$DashboardModelImplFromJson(Map<String, dynamic> json) =>
    _$DashboardModelImpl(
      today: json['today'] == null
          ? const DashboardPeriod()
          : DashboardPeriod.fromJson(json['today'] as Map<String, dynamic>),
      week: json['week'] == null
          ? const DashboardPeriod()
          : DashboardPeriod.fromJson(json['week'] as Map<String, dynamic>),
      month: json['month'] == null
          ? const DashboardMonth()
          : DashboardMonth.fromJson(json['month'] as Map<String, dynamic>),
      topProducts: (json['top_products'] as List<dynamic>?)
              ?.map((e) => TopProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentSales: (json['recent_sales'] as List<dynamic>?)
              ?.map((e) => RecentSale.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DashboardModelImplToJson(
        _$DashboardModelImpl instance) =>
    <String, dynamic>{
      'today': instance.today,
      'week': instance.week,
      'month': instance.month,
      'top_products': instance.topProducts,
      'recent_sales': instance.recentSales,
    };

_$DashboardPeriodImpl _$$DashboardPeriodImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardPeriodImpl(
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DashboardPeriodImplToJson(
        _$DashboardPeriodImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
    };

_$DashboardMonthImpl _$$DashboardMonthImplFromJson(Map<String, dynamic> json) =>
    _$DashboardMonthImpl(
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      averageTicket: (json['average_ticket'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DashboardMonthImplToJson(
        _$DashboardMonthImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'average_ticket': instance.averageTicket,
    };

_$TopProductImpl _$$TopProductImplFromJson(Map<String, dynamic> json) =>
    _$TopProductImpl(
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      units: (json['units'] as num?)?.toInt() ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$TopProductImplToJson(_$TopProductImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'units': instance.units,
      'revenue': instance.revenue,
    };

_$RecentSaleImpl _$$RecentSaleImplFromJson(Map<String, dynamic> json) =>
    _$RecentSaleImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      saleDate: json['sale_date'] as String? ?? '',
      branch: json['branch'] as String? ?? '',
      client: json['client'] as String? ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['payment_method'] as String? ?? '',
    );

Map<String, dynamic> _$$RecentSaleImplToJson(_$RecentSaleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sale_date': instance.saleDate,
      'branch': instance.branch,
      'client': instance.client,
      'total': instance.total,
      'payment_method': instance.paymentMethod,
    };
