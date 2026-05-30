import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/product_model.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return ProductService(http);
});

class ProductService {
  ProductService(this._http);

  final DioHttpClient _http;

  Future<List<ProductModel>> getProducts() async {
    const url = '/api/product/';
    DebugLogger(runtimeType).request(url);
    final response = await _http().get(url);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
