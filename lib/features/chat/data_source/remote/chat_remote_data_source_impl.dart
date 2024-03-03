import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/chat_ref.dart';
import 'package:techtalk/features/chat/data_source/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_model.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_room_model.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<void> createChatRoom(ChatRoomEntity room) async {
    final roomDoc = FirestoreChatRoomRef.doc(room.id);
    final roomSnapshot = await roomDoc.get();

    if (roomSnapshot.exists) {
      throw Exception('이미 채팅방이 존재합니다.');
    }

    await roomDoc.set(ChatRoomModel.fromEntity(room));
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms(
    InterviewType type, [
    TopicEntity? topic,
  ]) async {
    final snapshot = switch (type) {
      InterviewType.singleTopic => await FirestoreChatRoomRef.collection()
          .where(FirestoreChatRoomRef.typeField, isEqualTo: type.name)
          .where(FirestoreChatRoomRef.topicIdsField, arrayContains: topic!.id)
          .get(),
      InterviewType.practical => await FirestoreChatRoomRef.collection()
          .where(FirestoreChatRoomRef.typeField, isEqualTo: type.name)
          .get()
    };

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<ChatRoomModel> getChatRoom(String roomId) async {
    final snapshot = await FirestoreChatRoomRef.doc(roomId).get();

    return snapshot.data()!;
  }

  @override
  Future<void> deleteChatRoom(String roomId) async {
    await FirestoreChatRoomRef.doc(roomId).delete();
  }

  @override
  Future<void> uploadChats(
    String roomId, {
    required List<BaseChatEntity> messages,
  }) async {
    await FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        for (final message in messages) {
          final messageModel = ChatModel.fromEntity(message);
          transaction.set(
            FirestoreChatMessageRef.collection(roomId).doc(message.id),
            messageModel,
          );

          if (message is AnswerChatEntity) {
            transaction
              ..update(FirestoreChatRoomRef.doc(roomId), {
                if (message.answerState.isCorrect)
                  FirestoreChatRoomRef.correctAnswerCount:
                      FieldValue.increment(1),
                if (message.answerState.isWrong)
                  FirestoreChatRoomRef.incorrectAnswerCount:
                      FieldValue.increment(1),
              })
              ..update(
                FirestoreChatQnaRef.collection(roomId).doc(message.qnaId),
                {
                  FirestoreChatQnaRef.messageIdField: message.id,
                  FirestoreChatQnaRef.stateField: message.answerState.tag,
                },
              );
          }
        }
      },
    );
  }

  @override
  Future<List<ChatModel>> getChatHistory(String roomId) async {
    final snapshot = await FirestoreChatMessageRef.collection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<ChatModel> getChat(
    String roomId,
    String chatId,
  ) async {
    final snapshot = await FirestoreChatMessageRef.doc(roomId, chatId).get();

    return snapshot.data()!;
  }

  @override
  Future<ChatModel?> getLastChat(String roomId) async {
    final snapshot = await FirestoreChatMessageRef.collection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }

  @override
  Future<void> createChatQnas(
    String roomId, {
    required List<ChatQnaEntity> chatQnas,
  }) async {
    final roomModel = await getChatRoom(roomId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      for (final chatQna in chatQnas) {
        final qnaDoc = FirestoreChatQnaRef.doc(roomModel.id, chatQna.qna.id);
        transaction.set(
          qnaDoc,
          ChatQnaModel(
            id: qnaDoc.id,
          ),
        );
      }
    });
  }

  @override
  Future<List<ChatQnaModel>> getChatQnas(String roomId) async {
    final snapshot = await FirestoreChatQnaRef.collection(roomId).get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<void> uploadChatIssueReport(
    FeedbackChatEntity feedback,
    AnswerChatEntity answer,
  ) async {
    final docRef = FirebaseFirestore.instance
        .collection('Reports')
        .doc('chat')
        .collection('WrongFeedback')
        .doc();

    await docRef.set({
      'id': docRef.id,
      'feedback': ChatModel.fromEntity(feedback).toJson(),
      'answer': ChatModel.fromEntity(answer).toJson(),
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
