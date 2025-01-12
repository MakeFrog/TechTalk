import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/features/user/user.dart';

abstract class FirestoreUsersRef {
  static const String name = 'Users';
  static const String subCollectionName = 'Chats';
  static const String lastLoginDateField = 'last_login_date';
  static const String loginCountField = 'login_count';
  static const String completedInterviewCountField =
      'completed_interview_count';
  static const String uploadedYoutubeName = 'UploadedYoutube';
  static const String bookmarkedYoutubeName = 'BookmarkedYoutube';
  static const String watchedYoutubeHistoryName = 'WatchedYoutubeHistory';

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

  static DocumentReference uploadedYoutubeDoc(String contentId) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(uploadedYoutubeName)
          .doc(contentId);

  static DocumentReference bookMarkedYoutubeDoc(String contentId) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(bookmarkedYoutubeName)
          .doc(contentId);

  static DocumentReference watchedYoutubeHistoryDoc(String contentId) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(watchedYoutubeHistoryName)
          .doc(contentId);

  static CollectionReference chatSubCollection([String? id]) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(id ?? _userUid)
          .collection(subCollectionName);

  static Future<bool> isExist([String? uid]) async =>
      (await FirestoreUsersRef.doc(uid ?? _userUid).get()).exists;
}
