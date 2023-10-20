import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';

abstract interface class AuthRepository {
  Future<UserCredential> signInOAuth(UserAccountProvider provider);
  Future<void> signOut();
}
