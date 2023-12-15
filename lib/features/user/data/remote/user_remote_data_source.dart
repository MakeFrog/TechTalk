import 'package:techtalk/features/user/data/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData(String uid);
  Future<void> updateUserData(UserDataEntity data);
  Future<UserDataModel?> getUserData(String uid);
  Future<void> deleteUserData(String uid);
}
