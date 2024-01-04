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
}
