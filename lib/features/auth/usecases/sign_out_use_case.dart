import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/auth/auth.dart';

final class SignOutUseCase extends BaseNoParamUseCase<Result<void>> {
  SignOutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  FutureOr<Result<void>> call() async => _authRepository.signOutOauth();
}
