import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/sign_up/sign_up.dart';

final class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserData(String uid) async {
    _firestore.collection(FirestoreCollection.users.name).doc(uid);
  }
}
