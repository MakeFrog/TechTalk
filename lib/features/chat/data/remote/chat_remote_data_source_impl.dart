import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/interview_qna_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/repositories/entities/interviewer_avatar.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<String> createRoom({
    required String userUid,
    required String topicId,
    required int questionCount,
  }) async {
    // 채팅방 모델 생성
    final roomModel = ChatRoomModel(
      chatRoomId: StringGenerator.generateRandomString(),
      interviewerId: InterviewerAvatar.getRandomInterviewer().id,
      topicId: topicId,
      totalQuestionCount: questionCount,
      correctAnswerCount: 0,
      incorrectAnswerCount: 0,
    );

    // 채팅방 데이터 저장
    final roomDoc = _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomModel.chatRoomId);
    await roomDoc.set(roomModel.toJson());

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
          ).toFirestore(),
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
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .where('topic_id', isEqualTo: topicId)
        .get();

    return [
      ...snapshot.docs.map(ChatRoomModel.fromFirestore),
    ];
  }

  @override
  Future<ChatRoomModel> getRoom(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .get();

    return ChatRoomModel.fromFirestore(snapshot);
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
          final roomDoc = _firestore
              .collection(FirestoreCollection.users.name)
              .doc(userUid)
              .collection(FirestoreCollection.chats.name)
              .doc(roomId);
          final messageCollection =
              roomDoc.collection(FirestoreCollection.messages.name);

          // 메세지 업데이트
          // 유저의 응답메세지라면 채팅방의 정답 or 오답카운트도 업데이트한다
          for (final message in messages) {
            transaction.set(
              messageCollection.doc(message.id),
              MessageModel.fromEntity(message).toFirestore(),
            );
            if (message is SentMessageEntity) {
              final data = {
                message.answerState.isCorrect
                    ? 'correctAnswerCount'
                    : 'incorrectAnswerCount': FieldValue.increment(1),
              };
              transaction.update(roomDoc, data);
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
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .get();

    return [
      ...snapshot.docs.map(MessageModel.fromFirestore),
    ];
  }

  @override
  Future<MessageModel> getChat(
    String userUid,
    String roomId,
    String chatId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection(FirestoreCollection.messages.name)
        .doc(chatId)
        .get();

    return MessageModel.fromFirestore(snapshot);
  }

  @override
  Future<MessageModel?> getLastedChat(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return MessageModel.fromFirestore(snapshot.docs.first);
  }

  @override
  Future<List<InterviewQnaModel>> getChatQnAs(
    String userUid,
    String roomId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection('qna')
        .get();

    return [
      ...snapshot.docs.map(InterviewQnaModel.fromFirestore),
    ];
  }

  @override
  Future<void> addChatInfo() async {
    const userIdFromLocal = '2FXrROIad2RSKt37NA8tciQx7e53';

    FirebaseFirestore firestore = _firestore;

    // JSON 데이터
    Map<String, dynamic> chatData = {
      "interviewerId": "greenPlus",
      "topicId": "flutter",
      "totalQuestionCount": 5,
      "correctAnswerCount": 3,
      "incorrectAnswerCount": 2,
      "chatRoomId": StringGenerator.generateRandomString(),
    };

    List<Map<String, dynamic>> messagesData = [
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 20)),
        "message": "수고하셨습니다. 면접을 종료합니다.",
        "type": "guide",
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 19)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 18)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-5", "state": "[c]"}
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 17)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-5",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 16)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 15)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 14)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-4", "state": "[c]"}
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 13)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-4",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 12)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 11)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-3", "state": "[w]"}
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 10)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-3",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 9)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 8)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 7)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-2", "state": "[w]"}
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 6)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-2",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 5)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 4)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 올바르게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 3)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-1", "state": "[c]"}
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 2)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-1",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": StringGenerator.generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 1)),
        "message": "반가워요! 지혜님. flutter면접 질문을 드리겠습니다",
        "type": "guide"
      }
    ];

    try {
      // "users" 컬렉션에 대한 레퍼런스
      CollectionReference usersRef = firestore.collection('users');

      // "userId" 문서에 대한 레퍼런스
      DocumentReference userDocRef =
          usersRef.doc(userIdFromLocal); // userId에 실제 사용자 ID를 넣어야 합니다.

      // "chats" 서브콜렉션에 대한 레퍼런스
      CollectionReference chatsRef = userDocRef.collection('chats');

      // "chatRoomId" 문서에 대한 레퍼런스
      DocumentReference chatRoomDocRef = chatsRef
          .doc(chatData['chatRoomId']); // chatRoomId에 실제 채팅방 ID를 넣어야 합니다.

      await chatRoomDocRef.set(chatData);

      // "messages" 서브콜렉션에 대한 레퍼런스
      CollectionReference messagesRef = chatRoomDocRef.collection('messages');

      // "messages" 서브콜렉션에 새로운 문서 추가
      for (int i = 0; i < messagesData.length; i++) {
        await messagesRef.doc(messagesData[i]['id']).set(messagesData[i]);
      }

      print('성공');
      // print('새로운 문서가 "messages" 서브콜렉션에 추가되었습니다. 문서 ID: ${newDocRef.id}');
    } catch (e) {
      print('문서 추가 중 오류 발생: $e');
    }
  }
}
