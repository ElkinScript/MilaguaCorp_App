import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/client_model.dart';
import '../interfaces/client_interface.dart';

final clientServiceProvider = Provider<ClientService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return ClientService(http);
});

class ClientService implements ClientInterface {
  ClientService(this._http);

  final DioHttpClient _http;

  @override
  Future<List<ClientModel>> search(String query) async {
    const url = '/api/client/';
    DebugLogger(runtimeType).request(url, {'search': query});
    final r = await _http().get(url, queryParameters: {'search': query});
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    final list = r.data as List<dynamic>;
    return list
        .map((e) => ClientModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ClientModel> create(NewClientInput input) async {
    const url = '/api/client/';
    final body = input.toRequestJson();
    DebugLogger(runtimeType).request(url, body);
    final r = await _http().post(url, data: body);
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    return ClientModel.fromJson(r.data as Map<String, dynamic>);
  }

  @override
  Future<ClientModel> getById(int id) async {
    final url = '/api/client/$id/';
    DebugLogger(runtimeType).request(url);
    final r = await _http().get(url);
    DebugLogger(runtimeType).response(url, [r.statusCode, r.data]);
    return ClientModel.fromJson(r.data as Map<String, dynamic>);
  }
}
