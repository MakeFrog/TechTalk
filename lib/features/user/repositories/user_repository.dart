import 'package:techtalk/features/user/models/user_data_model.dart';

abstract interface class UserRepository {
  Future<void> createUserData(UserDataModel data);
  Future<UserDataModel?> getUserData(String uid);
  Future<bool> isExistNickname(String nickname);
}
