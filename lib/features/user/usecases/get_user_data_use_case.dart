import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

final getUserDataUseCase = locator<GetUserDataUseCase>();

final class GetUserDataUseCase {
  const GetUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<UserDataModel?> call(String uid) async {
    return _userRepository.getUserData(uid);
  }
}