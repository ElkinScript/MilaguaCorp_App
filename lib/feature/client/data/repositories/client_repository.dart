import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../modules/common/exceptions/server_exception.dart';
import '../../domain/client_model.dart';
import '../services/client_service.dart';

final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  final service = ref.watch(clientServiceProvider);
  return ClientRepository(service);
});

class ClientRepository {
  ClientRepository(this._service);

  final ClientService _service;

  Future<Either<ServerException, List<ClientModel>>> search(
    String query,
  ) async {
    try {
      final result = await _service.search(query);
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, ClientModel>> create(
    NewClientInput input,
  ) async {
    try {
      final result = await _service.create(input);
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, ClientModel>> getById(int id) async {
    try {
      final result = await _service.getById(id);
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }
}
