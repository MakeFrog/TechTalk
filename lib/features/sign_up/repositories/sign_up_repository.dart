import 'package:techtalk/app/di/locator.dart';

final signUpRepository = locator<SignUpRepository>();

abstract interface class SignUpRepository {
  Future<void> createUserData(String uid);
}
