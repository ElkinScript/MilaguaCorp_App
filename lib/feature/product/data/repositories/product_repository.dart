import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../modules/common/exceptions/server_exception.dart';
import '../../domain/product_model.dart';
import '../services/product_service.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final service = ref.watch(productServiceProvider);
  return ProductRepository(service);
});

class ProductRepository {
  ProductRepository(this._service);

  final ProductService _service;

  Future<Either<ServerException, List<ProductModel>>> getProducts() async {
    try {
      final result = await _service.getProducts();
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }
}
