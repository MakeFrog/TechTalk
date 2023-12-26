import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';
import 'package:techtalk/features/user/data/models/users_ref.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  Future<bool> _isExistNickname(
    String nickname,
  ) async {
    return FirestoreUsersRef.collection()
        .where(
          'nickname',
          isEqualTo: nickname,
        )
        .count()
        .get()
        .then(
          (value) => value.count > 0,
        );
  }

  @override
  Future<void> createUserData() async {
    if (await FirestoreUsersRef.isExist()) {
      throw const AlreadyExistUserDataException();
    }

    final userData = FirestoreUsersRef.doc();

    await userData.set(
      UserDataModel(uid: userData.id),
    );
  }

  @override
  Future<void> updateUserData(UserDataEntity data) async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    UserDataModel userModel = UserDataModel.fromEntity(data);
    final orgUserData = await FirestoreUsersRef.doc().get().then(
          (value) => value.data()!,
        );

    if (userModel.nickname != orgUserData.nickname &&
        await _isExistNickname(data.nickname!)) {
      throw const AlreadyExistNicknameException();
    }

    userModel = UserDataModel(
      uid: userModel.uid,
      nickname: userModel.nickname,
      topicIds: userModel.topicIds != orgUserData.topicIds
          ? userModel.topicIds
          : null,
      jobGroupIds: userModel.jobGroupIds != orgUserData.jobGroupIds
          ? userModel.jobGroupIds
          : null,
    );
    await FirestoreUsersRef.doc(data.uid).update(
      userModel.toJson(),
    );
  }

  @override
  Future<UserDataEntity> getUserData() async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final snapshot = await FirestoreUsersRef.doc().get();

    return snapshot.data()!.toEntity();
  }

  @override
  Future<void> deleteUserData() async {
    await FirestoreUsersRef.doc().delete();
  }
}
