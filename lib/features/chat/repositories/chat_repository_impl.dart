import 'dart:math';

import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<ChatRoomListItemEntity>>> getChatRoomList(
      String topicId) async {
    try {
      final chatRoomResponse = await _remoteDataSource.getChatRoomList(topicId);
      final asyncResult = chatRoomResponse.map((e) async {
        final messageResponse =
            await _remoteDataSource.getLastedChatMessage(e.chatRoomId);
        return ChatRoomListItemEntity.fromFireStore(
          chatRoom: e,
          message: messageResponse,
        );
      }).toList();
      final result = await Future.wait(asyncResult);

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId) async {
    try {
      final response = await _remoteDataSource.getChatHistory(roomId);
      final result = response.map((e) => MessageEntity.fromModel(e)).toList();
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
      id: 'swift-$randomNum',
      content: LoremIpsumGenerator.generate(words: 10 + randomNum),
    );

    return Result.success(result);
  }
}
