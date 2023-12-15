import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data/models/chat_room_model.dart';
import 'package:techtalk/features/chat/data/models/message_model.dart';

abstract interface class ChatRemoteDataSource {
  /// 채방 리스트의 엔트리 정보 호출
  Future<List<ChatRoomModel>> getChatRoomList(String topicId);

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<MessageModel> getLastedChatMessage(String chatRoomId);

  /// 채팅 메세지 리시트 호출
  Future<List<MessageModel>> getChatHistory(String chatRoomId);

  /// 채팅방 답변 개수 업데이트
  Future<void> updateChatRoomAnswerCount(
      {required String chatRoomId, required AnswerState answerState});

  /// 채팅 메세지 업데이트
  Future<void> updateChatMessage(
      {required String chatRoomId, required List<MessageModel> messages});

  /// 채팅방 기본 정보 업데이트
  Future<void> setBasicChatRoomInfo(ChatRoomModel chatRoomInfo);

  /// [임시]
  Future<void> addChatInfo();
}
