import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

enum FirestoreCollection {
  users('users'),
  usersWrongAnswers('wrongAnswers'),
  usersWrongAnswersQna('qna'),
  interview('interview'),
  interviewQuestions('questions'),
  chats('chats'),
  chatsQna('qna'),
  messages('messages');

  final String name;

  const FirestoreCollection(this.name);
}

abstract class FirestoreTopicCategoryRef {
  static const String name = 'TopicCategories';

  static CollectionReference<Map<String, dynamic>> collection() =>
      _firestore.collection(name);

  static DocumentReference<Map<String, dynamic>> doc(String id) =>
      _firestore.collection(name).doc(id);
}

abstract class FirestoreTopicRef {
  static const String name = 'Topics';

  static CollectionReference<Map<String, dynamic>> collection() =>
      _firestore.collection(name);

  static DocumentReference<Map<String, dynamic>> doc(String id) =>
      _firestore.collection(name).doc(id);
}

abstract class FirestoreTopicQuestionRef {
  static const String name = 'Questions';

  static CollectionReference<Map<String, dynamic>> collection(String topicId) =>
      FirestoreTopicRef.doc(topicId).collection(name);

  static DocumentReference<Map<String, dynamic>> doc(
    String topicId,
    String id,
  ) =>
      FirestoreTopicRef.doc(topicId).collection(name).doc(id);
}

abstract class FirestoreUserRef {
  static const String name = 'Users';
  static String get _userUid => FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>> collection() =>
      _firestore.collection(name);

  static DocumentReference<Map<String, dynamic>> doc([String? id]) =>
      _firestore.collection(name).doc(id ?? _userUid);
}

abstract class FirestoreChatRoomRef {
  static const String name = 'Chats';

  static CollectionReference<Map<String, dynamic>> collection() =>
      FirestoreUserRef.doc().collection(name);

  static DocumentReference<Map<String, dynamic>> doc(String id) =>
      FirestoreUserRef.doc().collection(name).doc(id);
}

abstract class FirestoreChatMessageRef {
  static const String name = 'Messages';

  static CollectionReference<Map<String, dynamic>> collection(String roomId) =>
      FirestoreChatRoomRef.doc(roomId).collection(name);

  static DocumentReference<Map<String, dynamic>> doc(
    String roomId,
    String id,
  ) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).doc(id);
}

abstract class FirestoreChatQnaRef {
  static const String name = 'Qna';

  static CollectionReference<Map<String, dynamic>> collection(String roomId) =>
      FirestoreChatRoomRef.doc(roomId).collection(name);

  static DocumentReference<Map<String, dynamic>> doc(
    String roomId,
    String id,
  ) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).doc(id);
}

abstract class FirestoreWrongAnswerRef {
  static const String name = 'WrongAnswers';

  static CollectionReference<Map<String, dynamic>> collection() =>
      FirestoreUserRef.doc().collection(name);

  static DocumentReference<Map<String, dynamic>> doc(String id) =>
      FirestoreUserRef.doc().collection(name).doc(id);
}
