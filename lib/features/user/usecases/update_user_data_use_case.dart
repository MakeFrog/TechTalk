import 'dart:async';

import 'package:techtalk/core/utils/base/base_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class UpdateUserDataUseCase
    extends BaseUseCase<UserDataEntity, Result<void>> {
  UpdateUserDataUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(UserDataEntity request) async {
    return _userRepository.updateUserData(request);
  }
}
