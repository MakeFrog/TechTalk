import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<String>> createRoom({
    required String topicId,
    required int questionCount,
  }) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final roomId = await _remoteDataSource.createRoom(
      userUid: userUid,
      topicId: topicId,
      questionCount: questionCount,
    );

    return Result.success(roomId);
  }

  @override
  Future<Result<ChatRoomEntity>> getRoom(String roomId) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final roomModel = await _remoteDataSource.getRoom(
      userUid,
      roomId,
    );

    return Result.success(
      ChatRoomEntity(
        chatRoomId: roomId,
        interviewerInfo:
            InterviewerAvatar.getAvatarInfoById(roomModel.interviewerId),
        topic: Topic.getTopicById(roomModel.topicId),
        qnaProgressInfo: ChatQnaProgressInfoEntity(
          totalQuestionCount: roomModel.totalQuestionCount,
          correctAnswerCount: roomModel.correctAnswerCount,
          incorrectAnswerCount: roomModel.incorrectAnswerCount,
        ),
        lastChatMessage: 'test',
        lastChatDate: DateTime.now(),
      ),
    );
  }

  @override
  Future<Result<List<ChatRoomEntity>>> getInterviewRooms(String topicId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final roomModels = await _remoteDataSource.getInterviewRooms(
        userUid,
        topicId,
      );
      final asyncResult = roomModels.map((e) async {
        final messageResponse = await _remoteDataSource.getLastedChatMessage(
          userUid,
          e.chatRoomId,
        );

        return ChatRoomEntity(
          chatRoomId: e.chatRoomId,
          interviewerInfo: InterviewerAvatar.getAvatarInfoById(e.interviewerId),
          topic: Topic.getTopicById(e.topicId),
          qnaProgressInfo: ChatQnaProgressInfoEntity(
            totalQuestionCount: e.totalQuestionCount,
            incorrectAnswerCount: e.incorrectAnswerCount,
            correctAnswerCount: e.correctAnswerCount,
          ),
          lastChatMessage: messageResponse.message,
          lastChatDate: messageResponse.timestamp,
        );
      });
      final result = await Future.wait(asyncResult);
      result.sort(
        (a, b) => a.lastChatDate == null || b.lastChatDate == null
            ? 1
            : b.lastChatDate!.compareTo(a.lastChatDate!),
      );

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final messageModels = await _remoteDataSource.getChatHistory(
        userUid,
        roomId,
      );

      return Result.success([
        ...messageModels.map((e) => e.toEntity()),
      ]);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> getIdealAnswers(
      InterviewQuestionEntity questionId) async {
    final List<String> result = ['모범답입니다1.', '모범답안입니다2'];

    return Result.success(result);
  }

  @override
  Future<Result<InterviewQuestionEntity>> getRandomQuestion(
      String categoryId) async {
    final int randomNum = Random().nextInt(20);
    final InterviewQuestionEntity result = InterviewQuestionEntity(
      id: 'swift-${StringGenerator.generateRandomString()}',
      content: LoremIpsumGenerator.generate(words: 10 + randomNum),
    );

    return Result.success(result);
  }

  @override
  Future<Result<void>> updateMessages(
    String roomId, {
    required List<MessageEntity> messages,
  }) async {
    try {
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _remoteDataSource.updateMessages(
        userUid,
        roomId,
        messages: messages,
      );

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateChatRoomAnswerCount(
      {required String chatRoomId, required AnswerState answerState}) async {
    try {
      final response = await _remoteDataSource.updateChatRoomAnswerCount(
          chatRoomId: chatRoomId, answerState: answerState);

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> setBasicChatRoomInfo(ChatRoomEntity chatRoomInfo) async {
    try {
      final response = await _remoteDataSource
          .setBasicChatRoomInfo(ChatRoomModel.fromEntity(chatRoomInfo));

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
