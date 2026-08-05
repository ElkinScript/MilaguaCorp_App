import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../modules/common/drivers/storage/local_storage.dart';
import '../../../modules/common/drivers/storage/local_storage_impl.dart';
import '../../../modules/common/exceptions/server_exception.dart';
import '../data/repositories/auth_repository.dart';
import '../domain/user_model.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  final storage = ref.watch(secureLocalDataSourceProvider);
  return AuthUseCase(repo, storage);
});

class AuthUseCase {
  AuthUseCase(this._repo, this._storage);

  final AuthRepository _repo;
  final LocalStorage _storage;

  Future<Either<ServerException, UserModel>> login(
    String username,
    String password,
  ) async {
    final tokenResult = await _repo.login(username, password);
    if (tokenResult.isLeft) return Left(tokenResult.left);

    final token = tokenResult.right;
    await _storage.setItem(AppStrings.keyTokenAccess, token.accessToken);
    await _storage.setItem(AppStrings.keyTokenRefresh, token.refreshToken);

    final profileResult = await _repo.getProfile();
    if (profileResult.isLeft) return Left(profileResult.left);

    final user = profileResult.right;
    await _saveProfile(user);
    return Right(user);
  }

  Future<void> logout() async {
    await _storage.removeAll();
  }

  Future<Either<ServerException, UserModel>> checkAuth() async {
    final token = await _storage.getItem(AppStrings.keyTokenAccess);
    if (token == null) {
      return Left(const ServerException('No se encontró una sesión activa.'));
    }
    return _repo.getProfile();
  }

  Future<Either<ServerException, UserModel>> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    File? profilePicture,
  }) async {
    final result = await _repo.updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePicture: profilePicture,
    );
    if (result.isRight) await _saveProfile(result.right);
    return result;
  }

  Future<void> _saveProfile(UserModel user) async {
    await _storage.setItem('mg_user_id', user.id.toString());
    await _storage.setItem('mg_username', user.username);
    await _storage.setItem('mg_first_name', user.firstName);
    await _storage.setItem('mg_last_name', user.lastName);
    await _storage.setItem('mg_email', user.email);
    if (user.groups.isNotEmpty) {
      await _storage.setItem('mg_group_name', user.groups.first);
    }
  }
}
