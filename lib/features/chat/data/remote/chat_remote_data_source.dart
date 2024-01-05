import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_message_model.dart';
import 'package:techtalk/features/chat/data/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class ChatRemoteDataSource {
  Future<void> createChatRoom(ChatRoomEntity room);

  Future<ChatRoomModel> getChatRoom(String roomId);

  /// 채방 리스트의 엔트리 정보 호출
  Future<List<ChatRoomModel>> getChatRooms(
    InterviewType type, [
    TopicEntity? topic,
  ]);

  Future<void> createChatMessages(
    String roomId, {
    required List<ChatMessageEntity> messages,
  });

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<ChatMessageModel?> getLastChatMessage(String roomId);

  /// 채팅 메세지 리시트 호출
  Future<List<ChatMessageModel>> getChatMessageHistory(String roomId);

  /// 채팅 메세지  호출
  Future<ChatMessageModel> getChatMessage(
    String roomId,
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
  Future<List<ChatQnaModel>> getChatQnas(String roomId);

  Future<void> updateChatQnas(
    String roomId, {
    required ChatQnaEntity qna,
  });
}
