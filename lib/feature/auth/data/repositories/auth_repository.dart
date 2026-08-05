import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_parser.dart';
import '../../../../modules/common/exceptions/server_exception.dart';
import '../../domain/auth_token_model.dart';
import '../../domain/user_model.dart';
import '../services/auth_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthRepository(service);
});

class AuthRepository {
  AuthRepository(this._service);

  final AuthService _service;

  Future<Either<ServerException, AuthTokenModel>> login(
    String username,
    String password,
  ) async {
    try {
      final result = await _service.login(username, password);
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, UserModel>> getProfile() async {
    try {
      final result = await _service.getProfile();
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, String>> refreshToken(String refresh) async {
    try {
      final result = await _service.refreshToken(refresh);
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, UserModel>> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    File? profilePicture,
  }) async {
    try {
      final result = await _service.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePicture: profilePicture,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }

  Future<Either<ServerException, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final result = await _service.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerException(parseError(e)));
    }
  }
}
