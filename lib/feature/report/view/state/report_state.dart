import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/report_model.dart';

part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState.initial() = _Initial;
  const factory ReportState.loading() = _Loading;
  const factory ReportState.loaded(ReportModel data) = _Loaded;
  const factory ReportState.error(String message) = _Error;
}
