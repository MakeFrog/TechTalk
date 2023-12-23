import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_message_model.dart';
import 'package:techtalk/features/chat/data/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data/models/chat_ref.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<ChatRoomModel> createRoom(ChatRoomEntity room) async {
    // 채팅방 모델 생성
    final roomModel = ChatRoomModel.fromEntity(room);
    // 채팅방 데이터 저장
    await FirestoreChatRoomRef.doc(roomModel.id).set(roomModel);

    // // 면접주제의 질문 목록 조회 후 무작위 [questionCount]만큼 id 추출
    // final questionsSnapshot =
    //     await FirestoreTopicQuestionRef.collection(topicId)
    //         .withConverter(
    //           fromFirestore: TopicQnaModel.fromFirestore,
    //           toFirestore: (value, options) => value.toJson(),
    //         )
    //         .get();
    // final questionIds = [
    //   ...questionsSnapshot.docs.map((e) => e.data()),
    // ]..shuffle();
    // final slicedQuestions = questionIds.sublist(0, questionCount);
    //
    // // 만들어진 채팅방 문서에 질문 리스트 추가
    // // 트랜잭션을 사용해 한번에 처리
    // final qnaCollection = _chatQnaCollection(roomModel.id);
    // await FirebaseFirestore.instance.runTransaction((transaction) async {
    //   for (final question in slicedQuestions) {
    //     final qnaDoc = qnaCollection.doc();
    //     transaction.set(
    //       qnaDoc,
    //       ChatQnaModel(
    //         id: qnaDoc.id,
    //         questionId: question.id,
    //       ).toJson(),
    //     );
    //   }
    // });

    return roomModel;
  }

  @override
  Future<List<ChatRoomModel>> getRooms(String topicId) async {
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
  Future<ChatRoomModel> getRoom(String roomId) async {
    final snapshot = await FirestoreChatRoomRef.doc(roomId).get();

    return snapshot.data()!;
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
  Future<List<ChatQnaModel>> getChatQnas(String roomId) async {
    final snapshot = await FirestoreChatQnaRef.collection(roomId).get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }
}
