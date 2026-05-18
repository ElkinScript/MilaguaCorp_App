import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../modules/common/exceptions/server_exception.dart';
import '../../domain/dashboard_model.dart';
import '../services/dashboard_service.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final service = ref.watch(dashboardServiceProvider);
  return DashboardRepository(service);
});

class DashboardRepository {
  DashboardRepository(this._service);

  final DashboardService _service;

  Future<Either<ServerException, DashboardModel>> getDashboard() async {
    try {
      final result = await _service.getDashboard();
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }
}
