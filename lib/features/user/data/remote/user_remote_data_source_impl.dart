import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  /// firestore에 저장된 users 컬렉션을 조회한다
  CollectionReference<UserDataModel> get _usersCollection =>
      FirestoreCollections.users.collection().withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  /// [data.uid]를 키로 가지는 도큐먼트를 조회한다
  DocumentReference<UserDataModel> _userDoc(String uid) =>
      FirestoreCollections.users.doc(uid).withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  /// [uid]를 키로 가지는 데이터가 있는지 여부
  Future<bool> _isExistUserData(String uid) async =>
      (await _userDoc(uid).get()).exists;

  Future<bool> _isExistNickname(
    String uid,
    String nickname,
  ) async {
    return _usersCollection
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
  Future<void> createUserData(String uid) async {
    if (await _isExistUserData(uid)) {
      throw const AlreadyExistUserDataException();
    }

    await _userDoc(uid).set(
      UserDataModel(uid: uid),
    );
  }

  @override
  Future<void> updateUserData(UserDataEntity data) async {
    if (!await _isExistUserData(data.uid)) {
      throw const NoUserDataException();
    }

    if (data.nickname != null &&
        await _isExistNickname(data.uid, data.nickname!)) {
      throw AlreadyExistNicknameException();
    }

    await _userDoc(data.uid).update(
      UserDataModel.fromEntity(data).toJson(),
    );
  }

  @override
  Future<UserDataModel?> getUserData(String uid) async {
    if (!await _isExistUserData(uid)) {
      return null;
    }

    final snapshot = await _userDoc(uid).get();

    return snapshot.data();
  }

  @override
  Future<void> deleteUserData(String uid) async {
    await _userDoc(uid).delete();
  }
}
