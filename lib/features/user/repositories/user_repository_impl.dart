import 'dart:io';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
    this._techSetRepository,
  );

  final UserRemoteDataSource _userRemoteDataSource;
  final TechSetRepository _techSetRepository;

  @override
  Future<Result<void>> createUserData() async {
    try {
      return Result.success(
        await _userRemoteDataSource.createUserData(),
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
  Future<Result<UserDataEntity>> getUserData() async {
    try {
      final response = await _userRemoteDataSource.getUserData();
      final List<SkillEntity> skills = response.topicIds != null
          ? response.topicIds!.map(_techSetRepository.getSkillById).toList()
          : [];

      final result = UserDataEntity.fromModel(response, skills);

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUserData() async {
    try {
      return Result.success(
        await _userRemoteDataSource.deleteUserData(),
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
