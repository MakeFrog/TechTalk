import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';

abstract interface class AuthRepository {
  /// OAuth [provider]를 통해 로그인
  Future<Result<UserCredential>> signInOAuth(UserAccountProvider provider);

  /// Ouath 로그아웃
  Future<Result<void>> signOutOauth();
}
