import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserUseCase extends BaseNoParamUseCase<Result<UserEntity>> {
  GetUserUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  @override
  Future<Result<UserEntity>> call() async {
    return _userRepository.getUser();
  }
}
