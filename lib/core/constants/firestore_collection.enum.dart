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

  FirestoreChatMessageCollection message(String id) =>
      FirestoreChatMessageCollection._(
        doc(id),
      );

  FirestoreChatQnaCollection qna(String id) => FirestoreChatQnaCollection._(
        doc(id),
      );
}

class FirestoreChatMessageCollection {
  FirestoreChatMessageCollection._(this._roomDoc);
  final DocumentReference<Map<String, dynamic>> _roomDoc;
  static const String name = 'Messages';

  CollectionReference<Map<String, dynamic>> collection() =>
      _roomDoc.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _roomDoc.collection(name).doc(id);
}

class FirestoreChatQnaCollection {
  FirestoreChatQnaCollection._(this._roomDoc);
  final DocumentReference<Map<String, dynamic>> _roomDoc;
  static const String name = 'Qna';

  CollectionReference<Map<String, dynamic>> collection() =>
      _roomDoc.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _roomDoc.collection(name).doc(id);
}

class FirestoreWrongAnswerCollection {
  FirestoreWrongAnswerCollection._(this._userDoc);
  final DocumentReference<Map<String, dynamic>> _userDoc;
  static const String name = 'WrongAnswers';

  CollectionReference<Map<String, dynamic>> collection() =>
      _userDoc.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _userDoc.collection(name).doc(id);
}
