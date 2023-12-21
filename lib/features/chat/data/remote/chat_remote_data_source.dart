import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/interview_qna_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';

abstract interface class ChatRemoteDataSource {
  Future<String> createRoom({
    required String userUid,
    required String topicId,
    required int questionCount,
  });

  Future<ChatRoomModel> getRoom(
    String userUid,
    String roomId,
  );

  /// 채방 리스트의 엔트리 정보 호출
  Future<List<ChatRoomModel>> getRooms(
    String userUid,
    String topicId,
  );

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<MessageModel?> getLastChat(
    String userUid,
    String chatRoomId,
  );

  /// 채팅 메세지 리시트 호출
  Future<List<MessageModel>> getChatHistory(
    String userUid,
    String chatRoomId,
  );

  /// 채팅 메세지 리시트 호출
  Future<MessageModel> getChat(
    String userUid,
    String chatRoomId,
    String chatId,
  );

  /// 채팅 메세지 업데이트
  Future<void> updateChats(
    String userUid,
    String roomId, {
    required List<MessageEntity> messages,
  });

  Future<List<InterviewQnaModel>> getChatQnAs(
    String userUid,
    String roomId,
  );
}
