import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/common/exceptions/server_exception.dart';
import '../data/repositories/client_repository.dart';
import '../domain/client_model.dart';

final clientUseCaseProvider = Provider<ClientUseCase>((ref) {
  final repo = ref.watch(clientRepositoryProvider);
  return ClientUseCase(repo);
});

class ClientUseCase {
  ClientUseCase(this._repo);

  final ClientRepository _repo;

  Future<Either<ServerException, List<ClientModel>>> search(String query) {
    return _repo.search(query);
  }

  Future<Either<ServerException, ClientModel>> register(NewClientInput input) {
    return _repo.create(input);
  }

  Future<Either<ServerException, ClientModel>> refresh(int clientId) {
    return _repo.getById(clientId);
  }
}
