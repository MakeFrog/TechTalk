import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;

  @override
  Future<void> createUserData(UserDataModel data) async {
    await _userRemoteDataSource.createUserData(data);
  }

  @override
  Future<UserDataModel?> getUserData(String uid) async {
    return _userRemoteDataSource.getUserData(uid);
  }
}
