import 'package:techtalk/app/di/locator.dart';

final signUpRemoteDataSource = locator<SignUpRemoteDataSource>();

abstract interface class SignUpRemoteDataSource {
  Future<void> createUserData(String uid);
}
