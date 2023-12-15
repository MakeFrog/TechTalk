import 'package:techtalk/features/user/user.dart';

final class CreateUserDataUseCase {
  const CreateUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<void> call() async {
    final result = await _userRepository.createUserData();
    return result.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        throw e;
      },
    );
  }
}
