import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/entities/chat_progress_info_entity.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  List<TopicEntity> _getChatRoomTopics(
    InterviewType type,
    List<String> topicIds,
  ) {
    final List<TopicEntity> topics = [];
    switch (type) {
      case InterviewType.topic:
        topics.add(topicRepository.getTopic(topicIds.first).getOrThrow());
      case InterviewType.practical:
        for (final String topicId in topicIds) {
          final topic = topicRepository.getTopic(topicId).getOrThrow();
          topics.add(topic);
        }
    }

    return topics;
  }

  @override
  Future<Result<void>> createChatRoom({
    required ChatRoomEntity room,
    required List<ChatQnaEntity> qnas,
    required List<ChatMessageEntity> messages,
  }) async {
    await _remoteDataSource.createChatRoom(room);
    await _remoteDataSource.createChatQnas(room.id, qnas: qnas);
    await _remoteDataSource.createChatMessages(room.id, messages: messages);

    final rooms = await switch (room.type) {
      InterviewType.topic => getChatRooms(room.type, room.topics.single),
      InterviewType.practical => getChatRooms(room.type),
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
        final messageResponse = await _remoteDataSource.getLastChatMessage(
          roomModel.id,
        );

        rooms.add(
          ChatRoomEntity(
            type: roomModel.type,
            id: roomModel.id,
            interviewer:
                InterviewerEntity.getAvatarInfoById(roomModel.interviewerId),
            topics: _getChatRoomTopics(type, roomModel.topicIds),
            progressInfo: ChatProgressInfoEntity(
              totalQuestionCount: roomModel.totalQuestionCount,
              correctAnswerCount: roomModel.correctAnswerCount,
              incorrectAnswerCount: roomModel.incorrectAnswerCount,
            ),
          ).copyWith(
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
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChatRoomEntity>> getChatRoom(String roomId) async {
    final roomModel = await _remoteDataSource.getChatRoom(roomId);

    return Result.success(
      ChatRoomEntity(
        type: roomModel.type,
        id: roomModel.id,
        interviewer:
            InterviewerEntity.getAvatarInfoById(roomModel.interviewerId),
        topics: _getChatRoomTopics(roomModel.type, roomModel.topicIds),
        progressInfo: ChatProgressInfoEntity(
          totalQuestionCount: roomModel.totalQuestionCount,
          correctAnswerCount: roomModel.correctAnswerCount,
          incorrectAnswerCount: roomModel.incorrectAnswerCount,
        ),
      ),
    );
  }

  @override
  Future<Result<void>> createChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  }) async {
    try {
      return Result.success(
        await _remoteDataSource.createChatMessages(
          roomId,
          messages: messages,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ChatMessageEntity>>> getChatMessageHistory(
    String roomId,
  ) async {
    try {
      final messageModels =
          await _remoteDataSource.getChatMessageHistory(roomId);

      return Result.success([
        ...messageModels.map((e) => e.toEntity()),
      ]);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChatMessageEntity>> getChatMessage(
    String roomId,
    String chatId,
  ) async {
    try {
      final messageModel = await _remoteDataSource.getChatMessage(
        roomId,
        chatId,
      );

      return Result.success(messageModel.toEntity());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ChatQnaEntity>>> getChatQnAs(ChatRoomEntity room) async {
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
      final AnswerChatMessageEntity? answer;
      if (element.messageId != null) {
        final messageModel = await _remoteDataSource.getChatMessage(
          room.id,
          element.messageId!,
        );
        answer = messageModel.toEntity() as AnswerChatMessageEntity;
      } else {
        answer = null;
      }

      qnas.add(
        ChatQnaEntity(
          id: element.id,
          question: question,
          answer: answer,
        ),
      );
    });

    return Result.success(qnas);
  }

  @override
  Future<Result<void>> reportFeedback(
    FeedbackChatMessageEntity feedback,
    AnswerChatMessageEntity answer,
  ) async {
    try {
      return Result.success(
        await _remoteDataSource.createReport(
          feedback,
          answer,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
