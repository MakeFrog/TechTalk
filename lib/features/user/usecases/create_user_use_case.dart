import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

final class CreateUserUseCase extends BaseUseCase<UserEntity, Result<void>> {
  CreateUserUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(UserEntity data) async {
    await _userRepository.storeUserLocalInfo(data);
    return _userRepository.createUser(data);
  }
}
