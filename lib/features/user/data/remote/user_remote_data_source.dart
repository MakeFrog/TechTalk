import 'package:techtalk/features/user/models/user_data_model.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData(UserDataModel data);
  Future<UserDataModel?> getUserData(String uid);
}
