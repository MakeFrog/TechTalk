import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/features/interview_new/data/models/interview_message_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_qna_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_question_model.dart';
import 'package:techtalk/features/interview_new/data/models/interview_room_model.dart';
import 'package:techtalk/features/interview_new/data/remote/interview_remote_data_source.dart';
import 'package:techtalk/features/interview_new/interview.dart';

final class InterviewRemoteDataSourceImpl implements InterviewRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<InterviewQnaModel>> getQnAsOfTopic({
    required String userUid,
    required String topicId,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.usersWrongAnswerNote.name)
        .doc(topicId)
        .collection(FirestoreCollection.usersWrongAnswerNoteQnas.name)
        .get();

    return [
      ...snapshot.docs.map(InterviewQnaModel.fromFirestore),
    ];
  }

  @override
  Future<List<InterviewQuestionModel>> getQuestionsOfTopic(
    String topicId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.interview.name)
        .doc(topicId)
        .collection(FirestoreCollection.interviewQuestions.name)
        .get();

    if (snapshot.docs.isEmpty) {
      throw NoInterviewQuestionException(
        InterviewTopic.getTopicById(topicId).text,
      );
    }

    return [
      ...snapshot.docs.map(InterviewQuestionModel.fromFirestore),
    ];
  }

  @override
  Future<DateTime> getUpdateDateOfTopic(String topicId) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.interview.name)
        .doc(topicId)
        .get();
    try {
      final updateDate = snapshot.get('update_date') as Timestamp;

      return updateDate.toDate();
    } catch (e) {
      throw NoInterviewTopicException(
        InterviewTopic.getTopicById(topicId).text,
      );
    }
  }

  @override
  Future<InterviewQuestionModel> getQuestionOfTopic(
    String topicId,
    String questionId,
  ) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.interview.name)
        .doc(topicId)
        .collection(FirestoreCollection.interviewQuestions.name)
        .doc(questionId)
        .get();

    if (!snapshot.exists) {
      throw NoInterviewQuestionException(
        InterviewTopic.getTopicById(topicId).text,
      );
    }

    return InterviewQuestionModel.fromFirestore(snapshot);
  }

  @override
  Future<List<InterviewRoomModel>> getRooms({
    required String userUid,
    required String topicId,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .where('topicId', isEqualTo: topicId)
        .get();

    return [
      ...snapshot.docs.map(InterviewRoomModel.fromFirestore),
    ];
  }

  @override
  Future<InterviewMessageModel> getLastedRoomMessage({
    required String userUid,
    required String roomId,
  }) async {
    final chatMessageSnapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    return InterviewMessageModel.fromFirestore(
      chatMessageSnapshot.docs.first,
    );
  }

  @override
  Future<void> createRoom({
    required String userUid,
    required InterviewRoomEntity room,
  }) async {
    final roomModel = InterviewRoomModel.fromEntity(room);
    final roomCollection = _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name);

    await roomCollection.doc(room.chatRoomId).set(roomModel.toJson());
  }

  @override
  Future<List<InterviewMessageModel>> getChatHistory({
    required String userUid,
    required String roomId,
  }) async {
    final snapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userUid)
        .collection(FirestoreCollection.chats.name)
        .doc(roomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .get();

    return [
      ...snapshot.docs.map(InterviewMessageModel.fromFirestore),
    ];
  }

  @override
  Future<void> updateChatMessage({
    required String userUid,
    required String roomId,
    required List<InterviewMessageEntity> messages,
  }) async {
    try {
      final roomRef = _firestore
          .collection(FirestoreCollection.users.name)
          .doc(userUid)
          .collection(FirestoreCollection.chats.name)
          .doc(roomId);

      for (var message in messages) {
        final messageModel = InterviewMessageModel.fromEntity(message);
        final messageDoc = roomRef
            .collection(FirestoreCollection.messages.name)
            .doc(message.id);

        await _firestore.runTransaction((transaction) async {
          transaction.set(
            messageDoc,
            messageModel.toJson(),
          );
          if (message is SentMessageEntity) {
            transaction.update(
              roomRef,
              {
                message.answerState.isCorrect
                    ? 'correctAnswerCount'
                    : 'incorrectAnswerCount': FieldValue.increment(1),
              },
            );
          }
        });
      }
    } catch (e) {}
  }

  Future<void> addChatInfo(String userUid) async {
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
      final chatsRef = _firestore
          .collection(FirestoreCollection.users.name)
          .doc(userUid)
          .collection(FirestoreCollection.chats.name);

      // "chatRoomId" 문서에 대한 레퍼런스
      DocumentReference chatRoomDocRef = chatsRef
          .doc(chatData['chatRoomId']); // chatRoomId에 실제 채팅방 ID를 넣어야 합니다.

      await chatRoomDocRef.set(chatData);

      // "messages" 서브콜렉션에 대한 레퍼런스
      final messagesRef =
          chatRoomDocRef.collection(FirestoreCollection.messages.name);

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
