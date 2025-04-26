import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
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
  static const String markedCommonQuestionName = 'MarkedCommonQuestion';

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

  static CollectionReference<UploadedYoutubeModel>
      uploadedYoutubeCollection() => FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(uploadedYoutubeName)
          .withConverter(
            fromFirestore: UploadedYoutubeModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static DocumentReference bookMarkedYoutubeDoc(String contentId) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(bookmarkedYoutubeName)
          .doc(contentId);

  static CollectionReference<WatchedYoutubeModel>
      watchedYoutubeHistoryCollection() => FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(watchedYoutubeHistoryName)
          .withConverter(
            fromFirestore: WatchedYoutubeModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

  static CollectionReference<BookmarkedYoutubeModel>
      bookmarkedYoutubeHistoryCollection() => FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(bookmarkedYoutubeName)
          .withConverter(
            fromFirestore: BookmarkedYoutubeModel.fromFirestore,
            toFirestore: (value, _) => value.toJson(),
          );

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

  static DocumentReference markedCommonQuestionDoc(String docId) =>
      FirebaseFirestore.instance
          .collection(name)
          .doc(_userUid)
          .collection(markedCommonQuestionName)
          .doc(docId);

  static Future<bool> isExist([String? uid]) async =>
      (await FirestoreUsersRef.doc(uid ?? _userUid).get()).exists;
}
