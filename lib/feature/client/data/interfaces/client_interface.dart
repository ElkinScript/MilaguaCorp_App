import '../../domain/client_model.dart';

abstract class ClientInterface {
  Future<List<ClientModel>> search(String query);
  Future<ClientModel> create(NewClientInput input);
  Future<ClientModel> getById(int id);
}
