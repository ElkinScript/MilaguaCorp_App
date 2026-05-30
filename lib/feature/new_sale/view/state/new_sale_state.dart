import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../product/domain/product_model.dart';
import '../../domain/new_sale_model.dart';

part 'new_sale_state.freezed.dart';

@freezed
class NewSaleState with _$NewSaleState {
  const factory NewSaleState.initial() = _Initial;
  const factory NewSaleState.loading() = _Loading;
  const factory NewSaleState.ready({
    required List<ProductModel> products,
    required List<BranchModel> branches,
    required List<CartItem> cart,
    BranchModel? selectedBranch,
    @Default('efectivo') String paymentMethod,
    @Default('') String clientName,
    @Default('') String clientPhone,
    @Default('') String clientEmail,
    @Default('') String observation,
    @Default(true) bool hasContainer,
    @Default(false) bool submitting,
    @Default(false) bool success,
    String? submitError,
  }) = _Ready;
  const factory NewSaleState.error(String message) = _Error;
}
