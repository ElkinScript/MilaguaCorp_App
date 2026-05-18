import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../modules/common/exceptions/server_exception.dart';
import '../../domain/sale_model.dart';
import '../services/sale_service.dart';

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  final service = ref.watch(saleServiceProvider);
  return SaleRepository(service);
});

class SaleRepository {
  SaleRepository(this._service);

  final SaleService _service;

  Future<Either<ServerException, List<SaleModel>>> getSales() async {
    try {
      final result = await _service.getSales();
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }
}
