import 'dart:async';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class CreateUserUseCase extends BaseUseCase<UserEntity, Result<void>> {
  CreateUserUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(UserEntity data) async {
    return _userRepository.createUser(data);
  }
}