import 'dart:async';

import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class UpdateUserDataUseCase {
  UpdateUserDataUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Result<void>> call(UserDataEntity data) async {
    return _userRepository.updateUserData(data);
  }
}
