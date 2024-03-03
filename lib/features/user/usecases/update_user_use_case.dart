import 'dart:async';

import 'package:techtalk/core/modules/base_use_case/base_use_case.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/user/user.dart';

final class UpdateUserUseCase extends BaseUseCase<UserEntity, Result<void>> {
  UpdateUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(UserEntity request) async {
    return _userRepository.updateUser(request);
  }
}
