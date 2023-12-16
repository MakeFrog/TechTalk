import 'dart:math';

import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:techtalk/core/constants/stored_topics.dart';
import 'package:techtalk/core/helper/string_generator.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<ChatRoomEntity>>> getChatRoomList(String topicId) async {
    try {
      final chatRoomResponse = await _remoteDataSource.getChatRoomList(topicId);
      final asyncResult = chatRoomResponse.map((e) async {
        final messageResponse =
            await _remoteDataSource.getLastedChatMessage(e.chatRoomId);
        return ChatRoomEntity.fromFireStore(
            chatRoom: e,
            message: messageResponse,
            topic: StoredTopics.getById(e.topicId));
      }).toList();
      final result = await Future.wait(asyncResult);

      result.sort((a, b) => b.lastChatDate.compareTo(a.lastChatDate));

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId) async {
    try {
      final response = await _remoteDataSource.getChatHistory(roomId);
      final result = response.map(MessageEntity.fromModel).toList();
      return Result.success(result);
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
  Future<Result<void>> updateChatMessage(
      {required String chatRoomId,
      required List<MessageEntity> messages}) async {
    try {
      final response = await _remoteDataSource.updateChatMessage(
        chatRoomId: chatRoomId,
        messages: messages.map(MessageModel.fromEntity).toList(),
      );

      print("아지랑이 : ${messages.length}");

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
