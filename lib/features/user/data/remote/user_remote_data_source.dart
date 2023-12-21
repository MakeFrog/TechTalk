import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData();
  Future<void> updateUserData(UserDataEntity data);
  Future<UserDataEntity> getUserData();
  Future<void> deleteUserData();
}
