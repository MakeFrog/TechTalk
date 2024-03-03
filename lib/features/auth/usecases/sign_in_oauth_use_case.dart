import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/auth/auth.dart';

final class SignInOAuthUseCase
    extends BaseUseCase<UserAccountProvider, Result<UserCredential>> {
  SignInOAuthUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  FutureOr<Result<UserCredential>> call(UserAccountProvider request) async =>
      _authRepository.signInOAuth(request);
}
