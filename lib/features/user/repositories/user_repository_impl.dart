import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;

  @override
  Future<void> createUserData(UserDataEntity data) async {
    await _userRemoteDataSource.createUserData(data.toModel());
  }

  @override
  Future<UserDataEntity?> getUserData(String uid) async {
    var userData = await _userRemoteDataSource.getUserData(uid);

    if (userData == null) {
      return null;
    }

    return UserDataEntity.fromModel(userData);
  }

  @override
  Future<Result<bool>> isExistNickname(String nickname) async {
    try {
      final result = await _userRemoteDataSource.isExistNickname(nickname);

      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }
}
