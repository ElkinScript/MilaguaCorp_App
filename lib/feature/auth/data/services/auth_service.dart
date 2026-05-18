import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/common/drivers/http/dio_http_client.dart';
import '../../domain/auth_token_model.dart';
import '../../domain/user_model.dart';
import '../interfaces/auth_interface.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final http = ref.watch(dioHttpClientProvider);
  return AuthService(http);
});

class AuthService implements AuthInterface {
  AuthService(this._http);

  final DioHttpClient _http;

  @override
  Future<AuthTokenModel> login(String username, String password) async {
    final response = await _http().post(
      '/api/auth/token/',
      data: {'username': username, 'password': password},
    );
    return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> getProfile() async {
    final response = await _http().get('/api/auth/me/');
    // API returns {"message": "...", "user": {...}}
    final data = response.data as Map<String, dynamic>;
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  @override
  Future<String> refreshToken(String refresh) async {
    final response = await _http().post(
      '/api/auth/token/refresh/',
      data: {'refresh': refresh},
    );
    return (response.data as Map<String, dynamic>)['access'] as String;
  }
}
