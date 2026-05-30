import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/report_model.dart';

final reportServiceProvider = Provider<ReportService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return ReportService(http);
});

class ReportService {
  ReportService(this._http);

  final DioHttpClient _http;

  Future<ReportModel> getReport() async {
    const url = '/api/dashboard/';
    DebugLogger(runtimeType).request(url);
    final response = await _http().get(url);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    return ReportModel.fromJson(response.data as Map<String, dynamic>);
  }
}
