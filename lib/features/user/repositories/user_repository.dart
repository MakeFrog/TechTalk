import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<void> createUserData(UserDataEntity data);
  Future<UserDataEntity?> getUserData(String uid);
  Future<bool> isExistNickname(String nickname);
}
