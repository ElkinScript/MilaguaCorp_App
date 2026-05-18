import '../../domain/auth_token_model.dart';
import '../../domain/user_model.dart';

abstract class AuthInterface {
  Future<AuthTokenModel> login(String username, String password);
  Future<UserModel> getProfile();
  Future<String> refreshToken(String refresh);
}
