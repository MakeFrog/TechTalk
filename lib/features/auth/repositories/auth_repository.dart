import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/core/core.dart';

final authRepository = locator<AuthRepository>();

abstract interface class AuthRepository {
  Future<UserCredential> signInOAuth(UserAccountProvider provider);
  Future<void> signOut();
}
