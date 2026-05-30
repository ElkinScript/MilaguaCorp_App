import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../data/services/report_service.dart';
import '../state/report_state.dart';

final reportControllerProvider =
    StateNotifierProvider.autoDispose<ReportController, ReportState>(
  (ref) => ReportController(ref.watch(reportServiceProvider)),
);

class ReportController extends StateNotifier<ReportState> {
  ReportController(this._service) : super(const ReportState.initial()) {
    load();
  }

  final ReportService _service;

  Future<void> load() async {
    state = const ReportState.loading();
    try {
      final data = await _service.getReport();
      state = ReportState.loaded(data);
    } catch (e) {
      state = ReportState.error(parseError(e));
    }
  }
}
