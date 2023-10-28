import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/sign_up/data/remote/sign_up_remote_data_source.dart';

final class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> isExistNickname(String nickname) async {
    return _firestore
        .collection(FirestoreCollection.users.name)
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
