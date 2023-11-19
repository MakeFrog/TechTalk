import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/utils/result.dart';

abstract interface class AuthRepository {
  Future<Result<UserCredential>> signInOAuth(UserAccountProvider provider);
  Future<void> signOut();
}
