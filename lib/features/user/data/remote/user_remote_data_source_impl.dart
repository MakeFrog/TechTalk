import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// firestore에 저장된 users 컬렉션을 조회하는 공통 메소드
  CollectionReference<UserDataModel> get _userCollection => _firestore
      .collection(FirestoreCollection.users.name)
      .withConverter<UserDataModel>(
        fromFirestore: (snapshot, _) =>
            UserDataModel.fromJson(snapshot.data()!),
        toFirestore: (value, _) => value.toJson(),
      );

  /// [data.uid]를 키로 가지는 도큐먼트를 조회하는 공통 메소드
  DocumentReference<UserDataModel> _userDoc(String uid) =>
      _userCollection.doc(uid);

  /// [uid]를 키로 가지는 데이터가 있는지 여부
  Future<bool> _isExistUserData(String uid) async =>
      (await _userDoc(uid).get()).exists;

  @override
  Future<void> createUserData(UserDataModel data) async {
    if (await _isExistUserData(data.uid)) {
      return;
    }

    await _userDoc(data.uid).set(data);
  }

  @override
  Future<UserDataModel?> getUserData(String uid) async {
    if (await _isExistUserData(uid)) {
      final snapshot = await _userDoc(uid).get();

      return snapshot.data();
    }

    return null;
  }
}
