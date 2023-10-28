import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class CreateUserDataUseCase {
  const CreateUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<void> call(UserDataEntity data) async {
    await _userRepository.createUserData(data);
  }
}
