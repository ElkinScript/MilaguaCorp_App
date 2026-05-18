import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/dashboard_usecase.dart';
import '../state/dashboard_state.dart';

final dashboardControllerProvider =
    StateNotifierProvider.autoDispose<DashboardController, DashboardState>(
  (ref) => DashboardController(ref.watch(dashboardUseCaseProvider)),
);

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController(this._useCase) : super(const DashboardState.initial()) {
    load();
  }

  final DashboardUseCase _useCase;

  Future<void> load() async {
    state = const DashboardState.loading();
    final result = await _useCase.getDashboard();
    result.fold(
      (error) => state = DashboardState.error(error.message),
      (data) => state = DashboardState.loaded(data),
    );
  }
}
