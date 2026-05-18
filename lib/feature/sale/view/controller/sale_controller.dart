import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/sale_usecase.dart';
import '../state/sale_state.dart';

final saleControllerProvider =
    StateNotifierProvider.autoDispose<SaleController, SaleState>(
  (ref) => SaleController(ref.watch(saleUseCaseProvider)),
);

class SaleController extends StateNotifier<SaleState> {
  SaleController(this._useCase) : super(const SaleState.initial()) {
    load();
  }

  final SaleUseCase _useCase;

  Future<void> load() async {
    state = const SaleState.loading();
    final result = await _useCase.getSales();
    result.fold(
      (error) => state = SaleState.error(error.message),
      (sales) => state = SaleState.loaded(sales),
    );
  }
}
