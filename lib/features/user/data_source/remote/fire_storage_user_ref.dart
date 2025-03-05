import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class FireStorageUserRef {
  static const String profileImagePath = 'profileImage';
  static const String resumeFolder = 'resume';
  static const String portfolioFolder = 'portfolio';

  static String? get userUid => FirebaseAuth.instance.currentUser?.uid;

  /// 프로필사진 폴더에 파일 저장하기
  static Reference get profileImgRef {
    final uid = userUid ?? const Uuid().v1();
    return FirebaseStorage.instance.ref(profileImagePath).child(uid);
  }

  /// 이력서 폴더에 파일 저장하기
  static Reference get resumeFolderRef {
    final uid = userUid ?? const Uuid().v1();
    return FirebaseStorage.instance.ref(resumeFolder).child(uid);
  }

  /// 이력서,포트폴리오 폴더에 파일 저장하기
  static Reference get portfolioFolderRef {
    final uid = userUid ?? const Uuid().v1();
    return FirebaseStorage.instance.ref(portfolioFolder).child(uid);
  }
}
