import 'package:techtalk/features/user/data/models/user_data_model.dart';

abstract interface class UserRemoteDataSource {
  Future<void> createUserData(UserDataModel data);
  Future<UserDataModel?> getUserData(String uid);
  Future<bool> isExistNickname(String nickname);
}
