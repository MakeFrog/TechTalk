import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class DeleteUserDataUseCase extends BaseNoParamUseCase<Result<void>> {
  DeleteUserDataUseCase(this._userRepository);

  final UserRepository _userRepository;
  @override
  FutureOr<Result<void>> call() {
    return _userRepository.deleteUserData();
  }
}
