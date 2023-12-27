import 'package:techtalk/features/user/data/models/user_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  Future<UserModel> createUser();
  Future<UserModel> getUser([String? uid]);
  Future<void> updateUser(UserEntity data);
  Future<void> deleteUser();
}
