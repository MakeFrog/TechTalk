import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/user.dart';

abstract class FirestoreChatRoomRef {
  static const String name = 'Chats';
  static const String typeField = 'type';
  static const String topicIdsField = 'topic_ids';
  static const String totalQuestionCount = 'total_question_count';
  static const String correctAnswerCount = 'correct_answer_count';
  static const String incorrectAnswerCount = 'incorrect_answer_count';

  static CollectionReference<ChatRoomModel> collection() =>
      FirestoreUsersRef.doc().collection(name).withConverter(
            fromFirestore: ChatRoomModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<ChatRoomModel> doc(String id) =>
      FirestoreUsersRef.doc().collection(name).doc(id).withConverter(
            fromFirestore: ChatRoomModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreChatMessageRef {
  static const String name = 'Messages';

  static CollectionReference<ChatModel> collection(String roomId) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).withConverter(
            fromFirestore: ChatModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<ChatModel> doc(
    String roomId,
    String id,
  ) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).doc(id).withConverter(
            fromFirestore: ChatModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreChatQnaRef {
  static const String name = 'Qna';
  static const String messageIdField = 'message_id';
  static const String stateField = 'state';
  static const String questionField = 'question';
  static const String followUpQnasField = 'follow_up_qnas';

  static CollectionReference<ChatQnaModel> collection(String roomId) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).withConverter(
            fromFirestore: ChatQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<ChatQnaModel> doc(
    String roomId, [
    String? id,
  ]) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).doc(id).withConverter(
            fromFirestore: ChatQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}
