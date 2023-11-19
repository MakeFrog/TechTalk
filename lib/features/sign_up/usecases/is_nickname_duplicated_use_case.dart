import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

final class IsNicknameDuplicatedUseCase {
  const IsNicknameDuplicatedUseCase(
    this._signUpRepository,
  );

  final SignUpRepository _signUpRepository;

  Future<Result<bool>> call(String nickname) async {
    return _signUpRepository.isExistNickname(nickname);
  }
}
