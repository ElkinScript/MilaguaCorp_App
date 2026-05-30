// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    @JsonKey(name: 'today') @Default(ReportPeriod()) ReportPeriod today,
    @JsonKey(name: 'week') @Default(ReportPeriod()) ReportPeriod week,
    @JsonKey(name: 'month') @Default(ReportMonth()) ReportMonth month,
    @JsonKey(name: 'top_products')
    @Default([])
    List<TopProductReport> topProducts,
    @JsonKey(name: 'recent_sales')
    @Default([])
    List<RecentSaleReport> recentSales,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
}

@freezed
class ReportPeriod with _$ReportPeriod {
  const factory ReportPeriod({
    @Default(0.0) double total,
    @Default(0) int count,
  }) = _ReportPeriod;

  factory ReportPeriod.fromJson(Map<String, dynamic> json) =>
      _$ReportPeriodFromJson(json);
}

@freezed
class ReportMonth with _$ReportMonth {
  const factory ReportMonth({
    @Default(0.0) double total,
    @Default(0) int count,
    @JsonKey(name: 'average_ticket') @Default(0.0) double averageTicket,
  }) = _ReportMonth;

  factory ReportMonth.fromJson(Map<String, dynamic> json) =>
      _$ReportMonthFromJson(json);
}

@freezed
class TopProductReport with _$TopProductReport {
  const factory TopProductReport({
    @Default('') String name,
    @Default('') String type,
    @Default(0) int units,
    @Default(0.0) double revenue,
  }) = _TopProductReport;

  factory TopProductReport.fromJson(Map<String, dynamic> json) =>
      _$TopProductReportFromJson(json);
}

@freezed
class RecentSaleReport with _$RecentSaleReport {
  const factory RecentSaleReport({
    @Default(0) int id,
    @JsonKey(name: 'sale_date') @Default('') String saleDate,
    @Default('') String client,
    @Default('') String branch,
    @Default(0.0) double total,
    @JsonKey(name: 'payment_method') @Default('') String paymentMethod,
  }) = _RecentSaleReport;

  factory RecentSaleReport.fromJson(Map<String, dynamic> json) =>
      _$RecentSaleReportFromJson(json);
}
