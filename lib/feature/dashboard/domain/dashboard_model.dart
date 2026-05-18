// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    @JsonKey(name: 'today') @Default(DashboardPeriod()) DashboardPeriod today,
    @JsonKey(name: 'week') @Default(DashboardPeriod()) DashboardPeriod week,
    @JsonKey(name: 'month') @Default(DashboardMonth()) DashboardMonth month,
    @JsonKey(name: 'top_products') @Default([]) List<TopProduct> topProducts,
    @JsonKey(name: 'recent_sales') @Default([]) List<RecentSale> recentSales,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
}

@freezed
class DashboardPeriod with _$DashboardPeriod {
  const factory DashboardPeriod({
    @Default(0.0) double total,
    @Default(0) int count,
  }) = _DashboardPeriod;

  factory DashboardPeriod.fromJson(Map<String, dynamic> json) =>
      _$DashboardPeriodFromJson(json);
}

@freezed
class DashboardMonth with _$DashboardMonth {
  const factory DashboardMonth({
    @Default(0.0) double total,
    @Default(0) int count,
    @JsonKey(name: 'average_ticket') @Default(0.0) double averageTicket,
  }) = _DashboardMonth;

  factory DashboardMonth.fromJson(Map<String, dynamic> json) =>
      _$DashboardMonthFromJson(json);
}

@freezed
class TopProduct with _$TopProduct {
  const factory TopProduct({
    @Default('') String name,
    @Default('') String type,
    @Default(0) int units,
    @Default(0.0) double revenue,
  }) = _TopProduct;

  factory TopProduct.fromJson(Map<String, dynamic> json) =>
      _$TopProductFromJson(json);
}

@freezed
class RecentSale with _$RecentSale {
  const factory RecentSale({
    @Default(0) int id,
    @JsonKey(name: 'sale_date') @Default('') String saleDate,
    @Default('') String branch,
    @Default('') String client,
    @Default(0.0) double total,
    @JsonKey(name: 'payment_method') @Default('') String paymentMethod,
  }) = _RecentSale;

  factory RecentSale.fromJson(Map<String, dynamic> json) =>
      _$RecentSaleFromJson(json);
}
