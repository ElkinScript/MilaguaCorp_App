import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/sale_model.dart';

final saleServiceProvider = Provider<SaleService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return SaleService(http);
});

class SaleService {
  SaleService(this._http);

  final DioHttpClient _http;

  Future<List<SaleModel>> getSales() async {
    const url = '/api/sale/';
    DebugLogger(runtimeType).request(url);
    final response = await _http().get(url);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => SaleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
