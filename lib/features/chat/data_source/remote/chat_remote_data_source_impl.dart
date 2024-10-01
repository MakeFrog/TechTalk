import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/app/di/modules/system_di.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
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

          /// 꼬리 질문 답변인지 여부를 판별
          /// 꼬리 질문이라면 채팅방의 정오답 개수를 업데이트하는 로직을 실행하지 않음

          if (message is AnswerChatEntity) {
            /// 꼬리 질문이 아니라면
            /// 1) 정오답 개수 업데이트
            /// 2) qna 정보 업데이트
            if (message.isFollowUpQna) {
              transaction
                ..update(
                  FirestoreChatRoomRef.doc(roomId),
                  {
                    if (message.answerState.isCorrect)
                      FirestoreChatRoomRef.correctAnswerCount:
                          FieldValue.increment(1),
                    if (message.answerState.isWrongOrInappropriate)
                      FirestoreChatRoomRef.incorrectAnswerCount:
                          FieldValue.increment(1),
                  },
                )
                ..update(
                  FirestoreChatQnaRef.collection(roomId).doc(message.qnaId),
                  {
                    FirestoreChatQnaRef.messageIdField: message.id,
                    FirestoreChatQnaRef.stateField: message.answerState.tag,
                  },
                );
            }

            /// 꼬리 질문이라면
            /// Qna > 꼬리질문 필드 업데이트
            else {
              transaction.update(
                FirestoreChatQnaRef.collection(roomId).doc(message.rootQnaId),
                {
                  FirestoreChatQnaRef.followUpQnasField: FieldValue.arrayUnion(
                    [
                      ChatQnaModel(
                        id: message.rootQnaId!,
                        state: message.answerState.tag,
                        messageId: message.id,
                      ).toJson(),
                    ],
                  )
                },
              );
            }
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
