import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
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
  Future<List<ChatRoomModel>> getInterviewRooms(
    String userUid,
    String topicId,
  );

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<MessageModel> getLastedChatMessage(
    String userUid,
    String chatRoomId,
  );

  /// 채팅 메세지 리시트 호출
  Future<List<MessageModel>> getChatHistory(
    String userUid,
    String chatRoomId,
  );

  /// 채팅방 답변 개수 업데이트
  Future<void> updateChatRoomAnswerCount(
      {required String chatRoomId, required AnswerState answerState});

  /// 채팅 메세지 업데이트
  Future<void> updateMessages(
    String userUid,
    String roomId, {
    required List<MessageEntity> messages,
  });

  /// 채팅방 기본 정보 업데이트
  Future<void> setBasicChatRoomInfo(ChatRoomModel chatRoomInfo);

  /// [임시]
  Future<void> addChatInfo();
}
