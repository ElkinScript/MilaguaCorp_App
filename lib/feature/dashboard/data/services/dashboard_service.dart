import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final response = await _http().get('/api/dashboard/');
    return DashboardModel.fromJson(response.data as Map<String, dynamic>);
  }
}
