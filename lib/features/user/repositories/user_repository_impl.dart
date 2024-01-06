import 'dart:io';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;

  @override
  Future<Result<UserEntity>> createUser() async {
    try {
      final createdUser = await _userRemoteDataSource.createUser();

      return Result.success(
        createdUser.toEntity(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser([String? uid]) async {
    try {
      final userModel = await _userRemoteDataSource.getUser(uid);

      return Result.success(
        userModel.toEntity(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUser(UserEntity data) async {
    try {
      return Result.success(
        await _userRemoteDataSource.updateUser(data),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUser() async {
    try {
      return Result.success(
        await _userRemoteDataSource.deleteUser(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile) async {
    try {
      final response =
          await _userRemoteDataSource.uploadImgFileAndGetUrl(imageFile);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isNicknameDuplicated(String nickname) async {
    try {
      final response = await _userRemoteDataSource.isExistNickname(nickname);

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
