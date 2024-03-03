import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_model.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_qna_model.dart';
import 'package:techtalk/features/chat/data_source/remote/models/chat_room_model.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class ChatRemoteDataSource {
  /// 채팅방 생성
  Future<void> createChatRoom(ChatRoomEntity room);

  /// 채팅방 정보 호출
  Future<ChatRoomModel> getChatRoom(String roomId);

  /// 채방 리스트의 정보 호출
  Future<List<ChatRoomModel>> getChatRooms(
    InterviewType type, [
    TopicEntity? topic,
  ]);

  //// 채팅방 삭제
  Future<void> deleteChatRoom(String roomId);

  /// 채팅 목록 업로드
  Future<void> uploadChats(
    String roomId, {
    required List<BaseChatEntity> messages,
  });

  /// 채팅방의 가장 마지막 채팅 메세지 호출
  Future<ChatModel?> getLastChat(String roomId);

  /// 채팅 메세지 기록 호출
  Future<List<ChatModel>> getChatHistory(String roomId);

  /// 채팅 메세지 호출
  Future<ChatModel> getChat(
    String roomId,
    String chatId,
  );

  /// 채팅 문답 데이터 생성
  Future<void> createChatQnas(
    String roomId, {
    required List<ChatQnaEntity> chatQnas,
  });

  /// 채팅 문답 데이터 호출
  Future<List<ChatQnaModel>> getChatQnas(String roomId);

  //// 리포트 업로드
  Future<void> uploadChatIssueReport(
    FeedbackChatEntity feedback,
    AnswerChatEntity answer,
  );
}
