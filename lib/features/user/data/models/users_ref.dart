import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';

abstract class FirestoreUsersRef {
  static const String name = 'Users';
  static String get _userUid => FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<UserDataModel> collection() =>
      FirebaseFirestore.instance.collection(name).withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static DocumentReference<UserDataModel> doc([String? id]) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(id ?? _userUid)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static Future<bool> isExist([String? uid]) async =>
      (await FirestoreUsersRef.doc(uid).get()).exists;
}
