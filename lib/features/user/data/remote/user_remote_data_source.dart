import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';

final userRemoteDataSource = locator<UserRemoteDataSource>();

abstract interface class UserRemoteDataSource {
  Future<void> createUserData(UserDataModel data);
  Future<UserDataModel?> getUserData(String uid);
}
