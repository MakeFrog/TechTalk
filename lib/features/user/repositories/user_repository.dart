import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<Result<void>> createUserData();
  Future<Result<void>> updateUserData(UserDataEntity data);
  Future<Result<UserDataEntity?>> getUserData();
  Future<Result<void>> deleteUserData();
  Future<Result<List<String>>> getUserTopicIds();
}
