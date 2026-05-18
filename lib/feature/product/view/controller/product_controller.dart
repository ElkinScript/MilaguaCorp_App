import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/product_usecase.dart';
import '../state/product_state.dart';

final productControllerProvider =
    StateNotifierProvider.autoDispose<ProductController, ProductState>(
  (ref) => ProductController(ref.watch(productUseCaseProvider)),
);

class ProductController extends StateNotifier<ProductState> {
  ProductController(this._useCase) : super(const ProductState.initial()) {
    load();
  }

  final ProductUseCase _useCase;

  Future<void> load() async {
    state = const ProductState.loading();
    final result = await _useCase.getProducts();
    result.fold(
      (error) => state = ProductState.error(error.message),
      (products) => state = ProductState.loaded(products),
    );
  }
}
