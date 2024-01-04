import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/user/data/models/user_model.dart';
import 'package:techtalk/features/user/data/models/users_ref.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  Future<bool> _isExistNickname(
    String nickname,
  ) async {
    final nicknameCount = await FirestoreUsersRef.collection()
        .where('nickname', isEqualTo: nickname)
        .count()
        .get();

    return nicknameCount.count > 0;
  }

  @override
  Future<UserModel> createUser() async {
    if (await FirestoreUsersRef.isExist()) {
      throw const AlreadyExistUserDataException();
    }

    final userData = FirestoreUsersRef.doc();
    final user = UserModel(uid: userData.id);

    await userData.set(user);

    return user;
  }

  @override
  Future<UserModel> getUser([String? uid]) async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final snapshot = await FirestoreUsersRef.doc(uid).get();

    return snapshot.data()!;
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final userModel = UserModel.fromEntity(user);

    if (await _isExistNickname(user.nickname!)) {
      throw const AlreadyExistNicknameException();
    }

    await FirestoreUsersRef.doc().update(
      userModel.toJson(),
    );
  }

  @override
  Future<void> deleteUser() async {
    await FirestoreUsersRef.doc().delete();
  }
}
