import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final response = await _http().get('/api/product/');
    final data = response.data as List<dynamic>;
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
