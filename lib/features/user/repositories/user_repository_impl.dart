import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;

  String get _userUid {
    try {
      return FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {
      throw const UnAuthorizedException();
    }
  }

  @override
  Future<Result<void>> createUserData() async {
    try {
      return Result.success(
        _userRemoteDataSource.createUserData(_userUid),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUserData(UserDataEntity data) async {
    try {
      return Result.success(
        _userRemoteDataSource.updateUserData(data),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserDataEntity?>> getUserData() async {
    try {
      var userData = await _userRemoteDataSource.getUserData(_userUid);

      if (userData == null) {
        return Result.success(null);
      }

      return Result.success(userData.toEntity());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUserData() async {
    try {
      return Result.success(
        await _userRemoteDataSource.deleteUserData(_userUid),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> getUserTopicIds() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _userRemoteDataSource.getUserData(uid);

      final topicIds = response?.topicIds ?? [];

      return Result.success(topicIds);
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
}
