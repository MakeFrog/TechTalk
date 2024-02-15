import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_history_collection_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class ChatRepository {
  Future<Result<void>> createChatRoom({
    required ChatRoomEntity room,
    required List<ChatQnaEntity> qnas,
    required List<ChatMessageEntity> messages,
  });

  /// 채팅 면접 리스트 호출
  Future<Result<List<ChatRoomEntity>>> getChatRooms(
    InterviewType type, [
    TopicEntity? topicId,
  ]);

  Future<Result<ChatRoomEntity>> getChatRoom(String roomId);

  /// 채팅 메세지 업데이트
  Future<Result<void>> createChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  });

  /// 채팅 메세지 리스트 호출
  Future<Result<ChatHistoryCollectionEntity>> getChatMessageHistory(
      String roomId);

  Future<Result<List<ChatQnaEntity>>> getChatQnAs(ChatRoomEntity room);

  Future<Result<void>> reportFeedback(
    FeedbackChatMessageEntity feedback,
    AnswerChatMessageEntity answer,
  );
}
