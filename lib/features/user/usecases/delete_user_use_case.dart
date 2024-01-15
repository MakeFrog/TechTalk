import 'dart:async';

import 'package:techtalk/core/utils/base/base_no_param_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class DeleteUserUseCase extends BaseNoParamUseCase<Result<void>> {
  DeleteUserUseCase(this._userRepository);

  final UserRepository _userRepository;
  @override
  Future<Result<void>> call() async {
    return _userRepository.deleteUser();
  }
}
