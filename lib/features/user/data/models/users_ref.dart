import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/features/user/data/models/user_model.dart';

abstract class FirestoreUsersRef {
  static const String name = 'Users';
  static String get _userUid => FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<UserModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static DocumentReference<UserModel> doc([String? id]) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(id ?? _userUid)
          .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static Future<bool> isExist([String? uid]) async =>
      (await FirestoreUsersRef.doc(uid ?? _userUid).get()).exists;
}
