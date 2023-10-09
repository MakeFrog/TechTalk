import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

final createUserDataUseCase = locator<CreateUserDataUseCase>();

final class CreateUserDataUseCase {
  const CreateUserDataUseCase(
    this._signUpRepository,
  );

  final SignUpRepository _signUpRepository;

  Future<void> call(String uid) async {
    await _signUpRepository.createUserData(uid);
  }
}
