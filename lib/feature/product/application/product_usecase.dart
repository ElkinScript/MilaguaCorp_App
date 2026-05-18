import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/common/exceptions/server_exception.dart';
import '../data/repositories/product_repository.dart';
import '../domain/product_model.dart';

final productUseCaseProvider = Provider<ProductUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return ProductUseCase(repo);
});

class ProductUseCase {
  ProductUseCase(this._repo);

  final ProductRepository _repo;

  Future<Either<ServerException, List<ProductModel>>> getProducts() =>
      _repo.getProducts();
}
