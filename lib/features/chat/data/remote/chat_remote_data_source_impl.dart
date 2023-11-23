import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/constants/firestore_collection.enum.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';

final class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<MessageModel>> getChatHistory(String chatRoomId) async {
    const userIdFromLocal = '2FXrROIad2RSKt37NA8tciQx7e53';
    final chatHistorySnapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userIdFromLocal)
        .collection(FirestoreCollection.chats.name)
        .doc(chatRoomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .withConverter(
          fromFirestore: MessageModel.fromFirestore,
          toFirestore: (model, _) => model.toJson(),
        )
        .get();

    final response = chatHistorySnapshot.docs.map((e) => e.data()).toList();

    return response;
  }

  @override
  Future<List<ChatRoomModel>> getChatRoomList(String topicId) async {
    const userIdFromLocal = '2FXrROIad2RSKt37NA8tciQx7e53';

    final chatRoomListSnapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userIdFromLocal)
        .collection(FirestoreCollection.chats.name)
        .withConverter(
          fromFirestore: ChatRoomModel.fromFirestore,
          toFirestore: (model, _) => model.toJson(),
        )
        .where('topicId', isEqualTo: topicId)
        .get();

    final response = chatRoomListSnapshot.docs.map((e) => e.data()).toList();

    return response;
  }

  @override
  Future<MessageModel> getLastedChatMessage(String chatRoomId) async {
    const userIdFromLocal = '2FXrROIad2RSKt37NA8tciQx7e53';

    final chatMessageSnapshot = await _firestore
        .collection(FirestoreCollection.users.name)
        .doc(userIdFromLocal)
        .collection(FirestoreCollection.chats.name)
        .doc(chatRoomId)
        .collection(FirestoreCollection.messages.name)
        .orderBy('timestamp', descending: true)
        .withConverter(
          fromFirestore: MessageModel.fromFirestore,
          toFirestore: (model, _) => model.toJson(),
        )
        .get();

    final response = chatMessageSnapshot.docs.first.data();

    return response;
  }

  @override
  Future<void> addChatInfo() async {
    const userIdFromLocal = '2FXrROIad2RSKt37NA8tciQx7e53';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // JSON 데이터
    Map<String, dynamic> chatData = {
      "interviewerId": "greenPlus",
      "topicId": "flutter",
      "totalQuestionCount": 5,
      "correctAnswerCount": 3,
      "incorrectAnswerCount": 2,
      "chatRoomId": generateRandomString(),
    };

    List<Map<String, dynamic>> messagesData = [
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 20)),
        "message": "수고하셨습니다. 면접을 종료합니다.",
        "type": "guide",
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 19)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 18)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-5", "state": "[c]"}
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 17)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-5",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 16)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 15)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 14)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-4", "state": "[c]"}
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 13)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-4",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 12)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 11)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-3", "state": "[w]"}
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 10)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-3",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 9)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 8)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 틀리게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 7)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-2", "state": "[w]"}
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 6)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-2",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 5)),
        "message": "다음 질문입니다.",
        "type": "guide",
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 4)),
        "message":
            "면접관이 피드백을 주는 메세지 내용입니다. 이 메세지에는 유저가 올바르게 답변한 내용을 다시 피드백하고 있습니다.",
        "type": "feedback"
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 3)),
        "message": "유저가 면접 질문에 답변하는 메세지 내용입니다.",
        "type": "sent",
        "qna": {"questionId": "flutter-1", "state": "[c]"}
      },
      {
        "id": generateRandomString(),
        "timestamp": Timestamp.fromDate(DateTime(2023, 10, 19, 15, 2)),
        "message": "Array보다 Set을 사용하는게 더 좋을 때는 언제일까요?",
        "type": "question",
        "qna": {
          "questionId": "flutter-1",
          "idealAnswers": ["모범답변1", "모범답변2"]
        }
      },
      {
        "id": generateRandomString(),
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

  String generateRandomString() {
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    Random random = Random();

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < 20; i++) {
      int randomIndex = random.nextInt(characters.length);
      buffer.write(characters[randomIndex]);
    }

    return buffer.toString();
  }
}
