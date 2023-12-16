import 'dart:async';

import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class UpdateUserDataUseCase {
  UpdateUserDataUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<void> call(UserDataEntity data) async {
    final result = await _userRepository.updateUserData(data);
    return result.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        throw e;
      },
    );
  }
}
