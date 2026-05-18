import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/sale_model.dart';

part 'sale_state.freezed.dart';

@freezed
class SaleState with _$SaleState {
  const factory SaleState.initial() = _Initial;
  const factory SaleState.loading() = _Loading;
  const factory SaleState.loaded(List<SaleModel> sales) = _Loaded;
  const factory SaleState.error(String message) = _Error;
}
