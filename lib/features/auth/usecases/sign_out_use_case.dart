import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/auth/auth.dart';

final class SignOutUseCase {
  const SignOutUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  Future<Result<void>> call() async {
    return _authRepository.signOut();
  }
}
