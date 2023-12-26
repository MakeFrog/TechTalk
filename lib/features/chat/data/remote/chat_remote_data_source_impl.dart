import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_message_model.dart';
import 'package:techtalk/features/chat/data/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data/models/chat_ref.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/topic/data/models/topic_ref.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<void> createChatRoom(ChatRoomEntity room) async {
    final roomDoc = FirestoreChatRoomRef.doc(room.id);
    final roomSnapshot = await roomDoc.get();

    if (roomSnapshot.exists) {
      throw Exception('이미 채팅방이 존재합니다.');
    }

    // 채팅방 데이터 저장
    await roomDoc.set(ChatRoomModel.fromEntity(room));
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms(String topicId) async {
    final snapshot = await FirestoreChatRoomRef.collection()
        .where(
          'topic_id',
          isEqualTo: topicId,
        )
        .get();

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
  Future<void> updateChatRoom(ChatRoomEntity room) async {
    final roomModel = ChatRoomModel.fromEntity(room);
    final roomDoc = FirestoreChatRoomRef.doc(roomModel.id);
    final roomSnapshot = await roomDoc.get();

    if (!roomSnapshot.exists) {
      throw Exception('채팅방이 존재하지 않습니다.');
    }

    // 채팅방 데이터 저장
    await roomDoc.set(roomModel);
  }

  @override
  Future<void> createChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  }) async {
    try {
      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          for (final message in messages) {
            final messageModel = ChatMessageModel.fromEntity(message);
            transaction.set(
              FirestoreChatMessageRef.collection(roomId).doc(message.id),
              messageModel,
            );

            if (message is AnswerChatMessageEntity) {
              transaction
                ..update(FirestoreChatRoomRef.doc(roomId), {
                  if (message.answerState.isCorrect)
                    'correct_answer_count': FieldValue.increment(1),
                  if (message.answerState.isWrong)
                    'incorrect_answer_count': FieldValue.increment(1),
                })
                ..update(
                  FirestoreChatQnaRef.collection(roomId).doc(message.qnaId),
                  {
                    'message_id': message.id,
                    'state': message.answerState.tag,
                  },
                );
            }
          }
        },
      );
    } catch (e) {}
  }

  @override
  Future<List<ChatMessageModel>> getChatMessageHistory(String roomId) async {
    final snapshot = await FirestoreChatMessageRef.collection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<ChatMessageModel> getChatMessage(
    String roomId,
    String chatId,
  ) async {
    final snapshot = await FirestoreChatMessageRef.doc(roomId, chatId).get();

    return snapshot.data()!;
  }

  @override
  Future<ChatMessageModel?> getLastChatMessage(String roomId) async {
    final snapshot = await FirestoreChatMessageRef.collection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }

  @override
  Future<void> updateChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  }) async {
    try {
      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          // 메세지 업데이트
          // 유저의 응답메세지라면 채팅방의 정답 or 오답카운트, 채팅방 qna 정보를 업데이트한다
          for (final message in messages) {
            final messageModel = ChatMessageModel.fromEntity(message);
            final messageDoc = await FirestoreChatMessageRef.collection(roomId)
                .doc(message.id)
                .get();

            if (messageDoc.exists) {
              transaction.set(
                FirestoreChatMessageRef.collection(roomId).doc(message.id),
                messageModel,
              );

              if (message is AnswerChatMessageEntity) {
                transaction
                  ..update(FirestoreChatRoomRef.doc(roomId), {
                    if (message.answerState.isCorrect)
                      'correct_answer_count': FieldValue.increment(1),
                    if (message.answerState.isWrong)
                      'incorrect_answer_count': FieldValue.increment(1),
                  })
                  ..update(
                    FirestoreChatQnaRef.collection(roomId).doc(message.qnaId),
                    {
                      'message_id': message.id,
                      'state': message.answerState.tag,
                    },
                  );
              }
            }
          }
        },
      );
    } catch (e) {}
  }

  @override
  Future<void> createChatQnas(
    String roomId, {
    required List<ChatQnaEntity> qnas,
  }) async {
    final roomModel = await getChatRoom(roomId);

    // 만들어진 채팅방 문서에 질문 리스트 추가
    // 트랜잭션을 사용해 한번에 처리
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      for (final qna in qnas) {
        final qnaDoc = FirestoreChatQnaRef.doc(roomModel.id, qna.id);
        transaction.set(
          qnaDoc,
          ChatQnaModel(
            id: qnaDoc.id,
            questionId: qna.question.id,
          ),
        );
      }
    });
  }

  @override
  Future<List<ChatQnaModel>> getChatQnas(ChatRoomEntity room) async {
    if (room.isTemporary) {
      final roomModel = ChatRoomModel.fromEntity(room);

      // 면접주제의 질문 목록 조회 후 무작위 [questionCount]만큼 id 추출
      final questionsSnapshot =
          await FirestoreTopicQuestionRef.collection(roomModel.topicId).get();
      final questionIds = [
        ...questionsSnapshot.docs.map((e) => e.data()),
      ]..shuffle();
      final slicedQuestions = questionIds.sublist(
        0,
        roomModel.totalQuestionCount,
      );

      return slicedQuestions.map(
        (e) {
          final qnaDoc = FirestoreChatQnaRef.doc(roomModel.id);

          return ChatQnaModel(
            id: qnaDoc.id,
            questionId: e.id,
          );
        },
      ).toList();
    }

    final snapshot = await FirestoreChatQnaRef.collection(room.id).get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<void> updateChatQnas(
    String roomId, {
    required ChatQnaEntity qna,
  }) async {
    await FirestoreChatQnaRef.collection(roomId)
        .doc(qna.id)
        .set(ChatQnaModel.fromEntity(qna));
  }
}
