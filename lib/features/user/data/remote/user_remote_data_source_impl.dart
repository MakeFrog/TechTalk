import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// firestore에 저장된 users 컬렉션을 조회한다
  CollectionReference<UserDataModel> get _userRef => _firestore
      .collection(FirestoreCollection.users.name)
      .withConverter<UserDataModel>(
        fromFirestore: (snapshot, _) => UserDataModel.fromFirestore(snapshot),
        toFirestore: (value, _) => value.toFirestore(),
      );

  /// [data.uid]를 키로 가지는 도큐먼트를 조회한다
  DocumentReference<UserDataModel> _userDoc(String uid) => _userRef.doc(uid);

  /// [uid]를 키로 가지는 데이터가 있는지 여부
  Future<bool> _isExistUserData(String uid) async =>
      (await _userDoc(uid).get()).exists;

  @override
  Future<void> createUserData(UserDataModel data) async {
    if (await _isExistUserData(data.uid!)) {
      throw CustomException(
        code: 'code',
        message: '이미 유저 데이터가 존재합니다.',
      );
    }

    await _userDoc(data.uid!).set(data);
  }

  @override
  Future<UserDataModel?> getUserData(String uid) async {
    if (await _isExistUserData(uid)) {
      final snapshot = await _userDoc(uid).get();

      return snapshot.data();
    }

    return null;
  }

  @override
  Future<bool> isExistNickname(String nickname) async {
    return _userRef
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
}
