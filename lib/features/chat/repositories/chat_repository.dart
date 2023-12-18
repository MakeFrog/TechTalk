import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract interface class ChatRepository {
  Future<Result<String>> createRoom({
    required String topicId,
    required int questionCount,
  });

  /// 채팅 면접 리스트 호출
  Future<Result<List<ChatRoomEntity>>> getRooms(String topicId);

  Future<Result<ChatRoomEntity>> getRoom(String roomId);

  /// 채팅 메세지 리스트 호출
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId);

  /// 채팅 메세지 업데이트
  Future<Result<void>> updateMessages(
    String roomId, {
    required List<MessageEntity> messages,
  });

  Future<Result<List<InterviewQnAEntity>>> getChatQnAs(String roomId);
}
