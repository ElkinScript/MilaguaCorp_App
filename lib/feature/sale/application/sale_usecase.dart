import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/common/exceptions/server_exception.dart';
import '../data/repositories/sale_repository.dart';
import '../domain/sale_model.dart';

final saleUseCaseProvider = Provider<SaleUseCase>((ref) {
  final repo = ref.watch(saleRepositoryProvider);
  return SaleUseCase(repo);
});

class SaleUseCase {
  SaleUseCase(this._repo);

  final SaleRepository _repo;

  Future<Either<ServerException, List<SaleModel>>> getSales() =>
      _repo.getSales();
}
