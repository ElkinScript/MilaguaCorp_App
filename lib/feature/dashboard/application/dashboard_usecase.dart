import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/common/exceptions/server_exception.dart';
import '../data/repositories/dashboard_repository.dart';
import '../domain/dashboard_model.dart';

final dashboardUseCaseProvider = Provider<DashboardUseCase>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardUseCase(repo);
});

class DashboardUseCase {
  DashboardUseCase(this._repo);

  final DashboardRepository _repo;

  Future<Either<ServerException, DashboardModel>> getDashboard() =>
      _repo.getDashboard();
}
