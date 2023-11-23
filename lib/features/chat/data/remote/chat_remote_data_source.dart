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

  /// [임시]
  Future<void> addChatInfo();

  static ChatRemoteDataSource get to => chatRemoteDataSource;
}
