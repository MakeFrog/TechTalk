import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/data/models/users_ref.dart';

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

  static CollectionReference<TopicQnaModel> collection(String topicId) =>
      FirestoreTopicRef.doc(topicId).collection(name).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<TopicQnaModel> doc(
    String topicId,
    String id,
  ) =>
      FirestoreTopicRef.doc(topicId).collection(name).doc(id).withConverter(
            fromFirestore: TopicQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreChatRoomRef {
  static const String name = 'Chats';

  static CollectionReference<Map<String, dynamic>> collection() =>
      FirestoreUsersRef.doc().collection(name);

  static DocumentReference<Map<String, dynamic>> doc(String id) =>
      FirestoreUsersRef.doc().collection(name).doc(id);
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
