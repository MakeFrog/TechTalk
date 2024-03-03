import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  /// 구글 Auth trigger
  Future<UserCredential> signInWithGoogle();

  /// 애플 Auth Trigger.
  Future<UserCredential> signInWithApple();

  /// Auth 로그아웃
  Future<void> signOut();
}
