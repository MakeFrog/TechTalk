import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

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
  Future<UserDataModel> getUserData(String uid) async {
    var userData = await _userRemoteDataSource.getUserData(uid);

    if (userData == null) {
      userData = UserDataModel(uid: uid);
      await createUserData(
        userData,
      );
    }

    return userData;
  }

  @override
  Future<bool> isExistNickname(String nickname) {
    return _userRemoteDataSource.isExistNickname(nickname);
  }
}
