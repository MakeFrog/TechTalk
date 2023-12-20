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

class FirestoreCollections {
  static FirestoreUserCollection get users => FirestoreUserCollection();
  static FirestoreTopicCollection get topics => FirestoreTopicCollection();
}

class FirestoreTopicCollection {
  static const String name = 'Topics';

  CollectionReference<Map<String, dynamic>> collection() =>
      _firestore.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _firestore.collection(name).doc(id);

  FirestoreTopicQuestionCollection question(String id) =>
      FirestoreTopicQuestionCollection._(
        doc(id),
      );
}

class FirestoreTopicQuestionCollection {
  FirestoreTopicQuestionCollection._(this._topicDoc);
  final DocumentReference<Map<String, dynamic>> _topicDoc;
  static const String name = 'Questions';

  CollectionReference<Map<String, dynamic>> collection() =>
      _topicDoc.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _topicDoc.collection(name).doc(id);
}

class FirestoreUserCollection {
  static const String name = 'Users';
  String get _userUid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> collection() =>
      _firestore.collection(name);

  DocumentReference<Map<String, dynamic>> doc([String? id]) =>
      _firestore.collection(name).doc(id ?? _userUid);

  FirestoreChatRoomCollection chatRoom([String? id]) =>
      FirestoreChatRoomCollection._(
        doc(id ?? _userUid),
      );
  FirestoreWrongAnswerCollection wrongAnswer([String? id]) =>
      FirestoreWrongAnswerCollection._(
        doc(id ?? _userUid),
      );
}

class FirestoreChatRoomCollection {
  FirestoreChatRoomCollection._(this._userDoc);
  final DocumentReference<Map<String, dynamic>> _userDoc;
  static const String name = 'Chats';

  CollectionReference<Map<String, dynamic>> collection() =>
      _userDoc.collection(name);

  DocumentReference<Map<String, dynamic>> doc(String id) =>
      _userDoc.collection(name).doc(id);

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
