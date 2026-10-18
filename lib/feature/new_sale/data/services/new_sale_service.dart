import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../../product/domain/product_model.dart';
import '../../domain/new_sale_model.dart';

final newSaleServiceProvider = Provider<NewSaleService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return NewSaleService(http);
});

class NewSaleService {
  NewSaleService(this._http);

  final DioHttpClient _http;

  Future<List<ProductModel>> getProducts() async {
    const url = '/api/product/';
    DebugLogger(runtimeType).request(url);
    final r = await _http().get(url);
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    final list = r.data as List<dynamic>;
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    const url = '/api/administration/data/';
    DebugLogger(runtimeType).request(url);
    final r = await _http().get(url);
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    final data = r.data as Map<String, dynamic>;
    return (data['paymentMethods'] as List<dynamic>? ?? [])
        .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> createSale(NewSaleRequest request) async {
    const url = '/api/sale/create/';
    final body = request.toRequestJson();
    DebugLogger(runtimeType).request(url, body);
    final r = await _http().post(url, data: body);
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    return r.data as Map<String, dynamic>;
  }
}
