import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class GetUserDataUseCase {
  const GetUserDataUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

  Future<Result<UserDataEntity?>> call() async {
    return _userRepository.getUserData();
  }
}
