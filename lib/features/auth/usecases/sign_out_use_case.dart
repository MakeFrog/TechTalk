import 'package:techtalk/features/auth/auth.dart';

final class SignOutUseCase {
  const SignOutUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  Future<void> call() async {
    return _authRepository.signOut();
  }
}
