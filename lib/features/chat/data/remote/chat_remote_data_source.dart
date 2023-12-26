import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_message_model.dart';
import 'package:techtalk/features/chat/data/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';

abstract interface class ChatRemoteDataSource {
  Future<void> createChatRoom(ChatRoomEntity room);

  Future<ChatRoomModel> getChatRoom(String roomId);

  /// 채방 리스트의 엔트리 정보 호출
  Future<List<ChatRoomModel>> getChatRooms(String topicId);

  /// 채팅방 업데이트
  Future<void> updateChatRoom(ChatRoomEntity room);

  Future<void> createChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  });

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<ChatMessageModel?> getLastChatMessage(String chatRoomId);

  /// 채팅 메세지 리시트 호출
  Future<List<ChatMessageModel>> getChatMessageHistory(String chatRoomId);

  /// 채팅 메세지  호출
  Future<ChatMessageModel> getChatMessage(
    String chatRoomId,
    String chatId,
  );

  /// 채팅 메세지 업데이트
  Future<void> updateChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  });

  Future<void> createChatQnas(
    String roomId, {
    required List<ChatQnaEntity> qnas,
  });
  Future<List<ChatQnaModel>> getChatQnas(ChatRoomEntity room);

  Future<void> updateChatQnas(
    String roomId, {
    required ChatQnaEntity qna,
  });
}
