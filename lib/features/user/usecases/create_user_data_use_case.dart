import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

final createUserDataUseCase = locator<CreateUserDataUseCase>();

final class CreateUserDataUseCase {
  const CreateUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<void> call(UserDataModel data) async {
    await _userRepository.createUserData(data);
  }
}
