import 'dart:io';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
    this._userLocalDataSource,
    this._techSetRepository,
  );

  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final TechSetRepository _techSetRepository;

  @override
  Future<Result<void>> createUser(UserEntity data) async {
    try {
      final createdUser = await _userRemoteDataSource.createUser(data);

      return Result.success(createdUser);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser([String? uid]) async {
    try {
      final remoteRes = await _userRemoteDataSource.getUser();
      final localRes = _userLocalDataSource.loadUserLocalInfo();
      final List<SkillEntity> skills = remoteRes.techSkills != null
          ? remoteRes.techSkills!.map(_techSetRepository.getSkillById).toList()
          : [];

      final result = UserEntity.fromModel(
        remoteRes,
        skills: skills,
        box: localRes,
      );

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUser(UserEntity data) async {
    try {
      await _userRemoteDataSource.updateUser(data);

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUser(UserEntity user) async {
    try {
      return Result.success(
        await _userRemoteDataSource.deleteUser(
          UserModel.fromEntity(user),
        ),
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

  @override
  Future<Result<void>> storeUserLocalInfo(UserEntity user) async {
    try {
      final response = await _userLocalDataSource.storeUserLocalInfo(user);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> increaseCompletedInterviewCount() async {
    try {
      final response =
          await _userRemoteDataSource.increaseCompletedInterviewCount();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateLastLoginDate() async {
    try {
      final response = await _userRemoteDataSource.updateLastLoginDate();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> disableReviewAvailableState() async {
    try {
      final response = await _userLocalDataSource.disableReviewAvailableState();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<bool> hasEnteredFirstInterview()  {
    try {
      final response = _userLocalDataSource.loadUserLocalInfo().hasEnteredFirstInterview;
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> changeFirstEnteredFieldToTrue() async{
    try {
      await _userLocalDataSource.changeFirstEnteredFieldToTrue();
      return Result.success(null);
    } on Exception catch(e) {
      return Result.failure(e);
    }
  }

}
