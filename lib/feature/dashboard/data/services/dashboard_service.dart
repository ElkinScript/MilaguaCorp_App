import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/dashboard_model.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return DashboardService(http);
});

class DashboardService {
  DashboardService(this._http);

  final DioHttpClient _http;

  Future<DashboardModel> getDashboard() async {
    const url = '/api/dashboard/';
    DebugLogger(runtimeType).request(url);
    final response = await _http().get(url);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    return DashboardModel.fromJson(response.data as Map<String, dynamic>);
  }
}
