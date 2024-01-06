import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  /// 구글 ID로 로그인한다.
  Future<UserCredential> signInWithGoogle();

  /// 애플 ID로 로그인한다.
  Future<UserCredential> signInWithApple();

  /// 로그아웃
  Future<void> signOut();
}
