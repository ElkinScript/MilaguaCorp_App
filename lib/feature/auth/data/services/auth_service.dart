import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
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
    const url = '/api/auth/token/';
    final body = {'username': username, 'password': password};
    DebugLogger(runtimeType).request(url, body);
    final response = await _http().post(url, data: body);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> getProfile() async {
    const url = '/api/auth/me/';
    DebugLogger(runtimeType).request(url);
    final response = await _http().get(url);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    // API returns {"message": "...", "user": {...}}
    final data = response.data as Map<String, dynamic>;
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  @override
  Future<String> refreshToken(String refresh) async {
    const url = '/api/auth/token/refresh/';
    final body = {'refresh': refresh};
    DebugLogger(runtimeType).request(url, body);
    final response = await _http().post(url, data: body);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    return (response.data as Map<String, dynamic>)['access'] as String;
  }

  @override
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    File? profilePicture,
  }) async {
    const url = '/api/auth/update-profile/';
    final formData = FormData.fromMap({
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (profilePicture != null)
        'profile_picture': await MultipartFile.fromFile(profilePicture.path),
    });
    DebugLogger(runtimeType).request(url);
    final response = await _http().patch(url, data: formData);
    DebugLogger(runtimeType)
        .response(url, [response.statusCode, response.data]);
    final data = response.data as Map<String, dynamic>;
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }
}
