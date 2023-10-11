import 'package:techtalk/features/sign_up/sign_up.dart';

final class IsExistNicknameUseCase {
  const IsExistNicknameUseCase(
    this._signUpRepository,
  );

  final SignUpRepository _signUpRepository;

  Future<bool> call(String nickname) async {
    return _signUpRepository.isExistNickname(nickname);
  }
}
