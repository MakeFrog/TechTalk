import 'package:techtalk/features/user/user.dart';

final class IsExistNicknameUseCase {
  const IsExistNicknameUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<bool> call(String nickname) async {
    return _userRepository.isExistNickname(nickname);
  }
}
