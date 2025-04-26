import 'dart:developer';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/follow_up_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<void>> createChatRoom({
    required ChatRoomEntity room,
    required List<ChatQnaEntity> qnas,
    required List<BaseChatEntity> messages,
  }) async {
    await _remoteDataSource.createChatRoom(room);
    await _remoteDataSource.createChatQnas(room.id, chatQnas: qnas);
    await _remoteDataSource.uploadChats(room.id, messages: messages);

    final rooms = await switch (room.type) {
      InterviewType.commonSingleTopic =>
        getChatRooms(room.type, room.topics.single),
      InterviewType.commonPracticalTopic => getChatRooms(room.type),
      InterviewType.resume => getChatRooms(room.type),
      InterviewType.youtube => throw UnimplementedError('유튜브 면접은 채팅방을 생성하지 않음'),
      // TODO: Handle this case.
      InterviewType.proficiency => throw UnimplementedError(),
    }
        .then((value) => value.getOrThrow());

    await Future.doWhile(() async {
      if (rooms.length > 20) {
        await _remoteDataSource.deleteChatRoom(rooms.last.id);
        rooms.removeLast();
        return true;
      }
      return false;
    });

    return Result.success(null);
  }

  @override
  Future<Result<List<ChatRoomEntity>>> getChatRooms(
    InterviewType type, [
    TopicEntity? topic,
  ]) async {
    try {
      final roomModels = await _remoteDataSource.getChatRooms(type, topic);
      final rooms = <ChatRoomEntity>[];
      await Future.forEach(roomModels, (roomModel) async {
        final messageResponse = await _remoteDataSource.getLastChat(
          roomModel.id,
        );

        rooms.add(
          ChatRoomEntity.fromModel(roomModel).copyWith(
            lastChatMessage: messageResponse?.message,
            lastChatDate: messageResponse?.timestamp,
          ),
        );
      });

      rooms.sort(
        (a, b) => b.lastChatDate!.compareTo(a.lastChatDate!),
      );

      return Result.success(rooms);
    } on Exception catch (e) {
      log('채팅방 목록 호출 실패 : ${e}');
      return Result.failure(const ChatRoomsFetchedFailedException());
    }
  }

  @override
  Future<Result<ChatRoomEntity>> getChatRoom(String roomId) async {
    final roomModel = await _remoteDataSource.getChatRoom(roomId);

    return Result.success(ChatRoomEntity.fromModel(roomModel));
  }

  @override
  Future<Result<void>> uploadChats(
    String roomId, {
    required List<BaseChatEntity> messages,
  }) async {
    try {
      return Result.success(
        await _remoteDataSource.uploadChats(
          roomId,
          messages: messages,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(const ChatRoomCreationFailedException());
    }
  }

  @override
  Future<Result<ChatHistoryCollectionEntity>> getChatHistory(
    String roomId,
  ) async {
    try {
      final messageModels = await _remoteDataSource.getChatHistory(roomId);

      final List<String> qnaInOrder = [];

      final response = messageModels.map((e) {
        if (ChatType.getTypeById(e.type).isSentMessage) {
          qnaInOrder.addFirst(e.qnaId!);
        }
        return e.toEntity();
      }).toList();

      return Result.success(ChatHistoryCollectionEntity(
          chatHistories: response, progressQnaIds: qnaInOrder));
    } on Exception catch (e) {
      return Result.failure(const ChatMessageFetchedFailedException());
    }
  }

  @override
  Future<Result<List<ChatQnaEntity>>> getResumeChatQnas(
      ChatRoomEntity room) async {
    try {
      final fetchedQnas = await _remoteDataSource.getChatQnas(room.id);

      final List<ChatQnaEntity> result = [];

      await Future.forEach(
        fetchedQnas,
        (element) async {
          // 응답 id가 있으면 응답 데이터 조회
          final AnswerChatEntity? answer;

          if (element.messageId != null) {
            final message = await _remoteDataSource.getChat(
              room.id,
              element.messageId!,
            );

            answer = message.toEntity() as AnswerChatEntity;
          } else {
            answer = null;
          }

          result.add(
            ChatQnaEntity.fromModelToResumeEntity(
              model: element,
              answerChatEntity: answer,
              followUpQnaEntity: element.followUpQnas?.first != null
                  ? FollowUpQnaEntity.fromModel(element.followUpQnas!.first)
                  : null,
            ),
          );
        },
      );

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ChatQnaEntity>>> getCommonChatQnas(
      ChatRoomEntity room) async {
    final roomQnAs = await _remoteDataSource.getChatQnas(room.id);

    final qnas = <ChatQnaEntity>[];
    await Future.forEach(roomQnAs, (element) async {
      // 질문 조회
      final question = await topicRepository
          .getTopicQna(
            element.topicId,
            element.id,
          )
          .then((value) => value.getOrThrow());

      // 응답 id가 있으면 응답 데이터 조회
      final AnswerChatEntity? answer;

      if (element.messageId != null) {
        final message = await _remoteDataSource.getChat(
          room.id,
          element.messageId!,
        );

        answer = message.toEntity() as AnswerChatEntity;
      } else {
        answer = null;
      }

      qnas.add(
        ChatQnaEntity(
          qna: question,
          message: answer,
          followUpQna: element.followUpQnas?.first != null
              ? FollowUpQnaEntity.fromModel(element.followUpQnas!.first)
              : null,
        ),
      );
    });

    return Result.success(qnas);
  }

  @override
  Future<Result<void>> uploadChatIssueReport(
    FeedbackChatEntity feedback,
    AnswerChatEntity answer,
  ) async {
    try {
      return Result.success(
        await _remoteDataSource.uploadChatIssueReport(
          feedback,
          answer,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(const ChatReportFailed());
    }
  }
}
