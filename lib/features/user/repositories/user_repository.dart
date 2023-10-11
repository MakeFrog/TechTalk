import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';

final userRepository = locator<UserRepository>();

abstract interface class UserRepository {
  Future<void> createUserData(UserDataModel data);
  Future<UserDataModel?> getUserData(String uid);
}
