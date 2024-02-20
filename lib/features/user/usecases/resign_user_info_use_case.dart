import 'dart:async';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class ResignUserInfoUseCase
    extends BaseUseCase<UserEntity, Result<void>> {
  ResignUserInfoUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  FutureOr<Result<void>> call(UserEntity request) {
    return _userRepository.quitUser(request);
  }
}
