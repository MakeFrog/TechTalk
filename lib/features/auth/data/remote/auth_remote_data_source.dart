import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/app/di/locator.dart';

final authRemoteDataSource = locator<AuthRemoteDataSource>();

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithApple();
  Future<void> signOut();
}
