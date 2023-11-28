import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class IsExistNicknameUseCase {
  const IsExistNicknameUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<Result<bool>> call(String nickname) async {
    return _userRepository.isExistNickname(nickname);
  }
}
