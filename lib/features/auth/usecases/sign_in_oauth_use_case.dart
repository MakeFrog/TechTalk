import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/auth/auth.dart';

final class SignInOAuthUseCase {
  const SignInOAuthUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  Future<Result<UserCredential>> call(UserAccountProvider provider) async {
    return _authRepository.signInOAuth(provider);
  }
}
