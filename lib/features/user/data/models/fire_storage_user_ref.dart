import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class FireStorageUserRef {
  static const String pathName = 'profileImage';
  static String? get _userUid => FirebaseAuth.instance.currentUser?.uid;

  static Reference get profileImgRef => FirebaseStorage.instance
      .ref(pathName)
      .child(_userUid ?? const Uuid().v1());
}
