import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Result<void>> createUser(UserEntity data);
  Future<Result<UserEntity>> getUser([String? uid]);
  Future<Result<void>> updateUser(UserEntity data);
  Future<Result<void>> deleteUser();
}
