import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/user.dart';

final class DeleteUserDataUseCase {
  DeleteUserDataUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<Result<void>> call() async {
    return _userRepository.deleteUserData();
  }
}