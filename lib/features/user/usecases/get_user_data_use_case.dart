import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserDataUseCase {
  const GetUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<UserDataEntity?> call(String uid) async {
    return _userRepository.getUserData(uid);
  }
}
