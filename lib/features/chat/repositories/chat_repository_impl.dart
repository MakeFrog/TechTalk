import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/chat_remote_data_source.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_history_collection_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
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
      InterviewType.singleTopic => getChatRooms(room.type, room.topics.single),
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
  Future<Result<List<ChatQnaEntity>>> getChatQnas(ChatRoomEntity room) async {
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
        final messageModel = await _remoteDataSource.getChat(
          room.id,
          element.messageId!,
        );
        answer = messageModel.toEntity() as AnswerChatEntity;
      } else {
        answer = null;
      }

      qnas.add(
        ChatQnaEntity(
          qna: question,
          message: answer,
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
