import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/chat/data/models/chat_message_model.dart';
import 'package:techtalk/features/chat/data/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/user/data/models/users_ref.dart';

abstract class FirestoreChatRoomRef {
  static const String name = 'Chats';

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

  static CollectionReference<ChatMessageModel> collection(String roomId) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).withConverter(
            fromFirestore: ChatMessageModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  static DocumentReference<ChatMessageModel> doc(
    String roomId,
    String id,
  ) =>
      FirestoreChatRoomRef.doc(roomId).collection(name).doc(id).withConverter(
            fromFirestore: ChatMessageModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );
}

abstract class FirestoreChatQnaRef {
  static const String name = 'Qna';

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
