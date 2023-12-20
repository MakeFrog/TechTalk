import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/interview_qna_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _userUid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<ChatRoomModel> get _roomCollection => _firestore
      .collection(FirestoreCollection.users.name)
      .doc(_userUid)
      .collection(FirestoreCollection.chats.name)
      .withConverter(
        fromFirestore: ChatRoomModel.fromFirestore,
        toFirestore: (value, options) => value.toJson(),
      );

  DocumentReference<ChatRoomModel> _roomDoc(String roomId) =>
      _roomCollection.doc(roomId);

  CollectionReference<MessageModel> _chatMessageCollection(String roomId) =>
      _roomDoc(roomId).collection('Messages').withConverter(
            fromFirestore: MessageModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  DocumentReference<MessageModel> _chatMessageDoc(
          String roomId, String chatId) =>
      _chatMessageCollection(roomId).doc(chatId);

  CollectionReference<InterviewQnaModel> _chatQnaCollection(String roomId) =>
      _roomDoc(roomId).collection('Qna').withConverter(
            fromFirestore: InterviewQnaModel.fromFirestore,
            toFirestore: (value, options) => value.toJson(),
          );

  @override
  Future<String> createRoom({
    required String userUid,
    required String topicId,
    required int questionCount,
  }) async {
    // 채팅방 모델 생성
    final roomModel = ChatRoomModel.random(
      topicId: topicId,
      totalQuestionCount: questionCount,
    );

    // 채팅방 데이터 저장
    final roomDoc = _roomDoc(roomModel.chatRoomId);
    await roomDoc.set(roomModel);

    // 면접주제의 질문 목록 조회 후 무작위 [questionCount]만큼 id 추출
    final questionsSnapshot = await _firestore
        .collection(FirestoreCollection.interview.name)
        .doc(topicId)
        .collection(FirestoreCollection.interviewQuestions.name)
        .get();
    final questionIds = [
      ...questionsSnapshot.docs.map((e) => e.id),
    ]..shuffle();
    final slicedQuestionIds = questionIds.sublist(0, questionCount);

    // 만들어진 채팅방 문서에 질문 리스트 추가
    // 트랜잭션을 사용해 한번에 처리
    final qnaCollection = roomDoc.collection('qna');
    await _firestore.runTransaction((transaction) async {
      for (final questionId in slicedQuestionIds) {
        final qnaDoc = qnaCollection.doc();
        transaction.set(
          qnaDoc,
          InterviewQnaModel(
            id: qnaDoc.id,
            questionId: questionId,
          ).toJson(),
        );
      }
    });

    return roomModel.chatRoomId;
  }

  @override
  Future<List<ChatRoomModel>> getRooms(
    String userUid,
    String topicId,
  ) async {
    final snapshot = await _roomCollection
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
  Future<ChatRoomModel> getRoom(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _roomDoc(roomId).get();

    return snapshot.data()!;
  }

  @override
  Future<void> updateChats(
    String userUid,
    String roomId, {
    required List<MessageEntity> messages,
  }) async {
    try {
      await _firestore.runTransaction(
        (transaction) async {
          final roomDoc = _roomDoc(roomId);
          final messageCollection = _chatMessageCollection(roomId);
          final qnaCollection = _chatQnaCollection(roomId);

          // 메세지 업데이트
          // 유저의 응답메세지라면 채팅방의 정답 or 오답카운트, 채팅방 qna 정보를 업데이트한다
          for (final message in messages) {
            final messageModel = MessageModel.fromEntity(message);

            transaction.set(
              messageCollection.doc(message.id),
              messageModel,
            );
            if (message is SentMessageEntity) {
              transaction
                ..update(roomDoc, {
                  if (message.answerState.isCorrect)
                    'correct_answer_count': FieldValue.increment(1),
                  if (message.answerState.isWrong)
                    'incorrect_answer_count': FieldValue.increment(1),
                })
                ..update(
                  qnaCollection.doc(message.qnaId),
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
  Future<List<MessageModel>> getChatHistory(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _chatMessageCollection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }

  @override
  Future<MessageModel> getChat(
    String userUid,
    String roomId,
    String chatId,
  ) async {
    final snapshot = await _chatMessageDoc(roomId, chatId).get();

    return snapshot.data()!;
  }

  @override
  Future<MessageModel?> getLastedChat(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _chatMessageCollection(roomId)
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }

  @override
  Future<List<InterviewQnaModel>> getChatQnAs(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _chatQnaCollection(roomId).get();

    return [
      ...snapshot.docs.map((e) => e.data()),
    ];
  }
}
