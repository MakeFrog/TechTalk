import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserDataUseCase {
  const GetUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<UserDataEntity?> call() async {
    final result = await _userRepository.getUserData();
    return result.fold(
      onSuccess: (value) {
        return value;
      },
      onFailure: (e) {
        throw e;
      },
    );
  }
}
