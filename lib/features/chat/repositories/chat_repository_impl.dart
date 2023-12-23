import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/entities/chat_progress_info_entity.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

final class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  Future<Result<ChatRoomEntity>> createRoom(ChatRoomEntity room) async {
    await _remoteDataSource.createRoom(room);

    return Result.success(room);
  }

  @override
  Future<Result<List<ChatRoomEntity>>> getRooms(TopicEntity topic) async {
    try {
      final roomModels = await _remoteDataSource.getRooms(topic.id);
      final rooms = <ChatRoomEntity>[];
      await Future.forEach(roomModels, (roomModel) async {
        final messageResponse = await _remoteDataSource.getLastChatMessage(
          roomModel.id,
        );
        return ChatRoomEntity(
          id: roomModel.id,
          interviewer:
              InterviewerEntity.getAvatarInfoById(roomModel.interviewerId),
          topic: topic,
          progressInfo: ChatProgressInfoEntity(
            totalQuestionCount: roomModel.totalQuestionCount,
            correctAnswerCount: roomModel.correctAnswerCount,
            incorrectAnswerCount: roomModel.incorrectAnswerCount,
          ),
        ).copyWith(
          lastChatMessage: messageResponse?.message,
          lastChatDate: messageResponse?.timestamp,
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
  Future<Result<ChatRoomEntity>> getRoom(String roomId) async {
    final roomModel = await _remoteDataSource.getRoom(roomId);

    return Result.success(
      ChatRoomEntity(
        id: roomModel.id,
        interviewer:
            InterviewerEntity.getAvatarInfoById(roomModel.interviewerId),
        topic: topicRepository.getTopic(roomModel.topicId).getOrThrow(),
        progressInfo: ChatProgressInfoEntity(
          totalQuestionCount: roomModel.totalQuestionCount,
          correctAnswerCount: roomModel.correctAnswerCount,
          incorrectAnswerCount: roomModel.incorrectAnswerCount,
        ),
      ),
    );
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
  Future<Result<void>> updateChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  }) async {
    try {
      final response = await _remoteDataSource.updateChatMessages(
        roomId,
        messages: messages,
      );

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ChatQnaEntity>>> getChatQnAs(
    String roomId,
  ) async {
    final roomModel = await _remoteDataSource.getRoom(
      roomId,
    );
    final roomQnAs = await _remoteDataSource.getChatQnas(
      roomId,
    );

    final qnas = <ChatQnaEntity>[];
    await Future.forEach(roomQnAs, (element) async {
      // 질문 조회
      final question = (await topicRepository.getTopicQna(
        roomModel.topicId,
        element.questionId,
      ))
          .getOrThrow();
      // 응답 id가 있으면 응답 데이터 조회
      final AnswerChatMessageEntity? answer;
      if (element.messageId != null) {
        final messageModel = await _remoteDataSource.getChatMessage(
          roomId,
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
}
