import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class ChatRepository {
  Future<Result<ChatRoomEntity>> createRoom(ChatRoomEntity room);

  /// 채팅 면접 리스트 호출
  Future<Result<List<ChatRoomEntity>>> getRooms(TopicEntity topicId);

  Future<Result<ChatRoomEntity>> getRoom(String roomId);

  /// 채팅 메세지 리스트 호출
  Future<Result<List<ChatMessageEntity>>> getChatMessageHistory(String roomId);

  /// 채팅 메세지  호출
  Future<Result<ChatMessageEntity>> getChatMessage(
    String chatRoomId,
    String chatId,
  );

  /// 채팅 메세지 업데이트
  Future<Result<void>> updateChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  });

  Future<Result<List<ChatQnaEntity>>> getChatQnAs(String roomId);
}
