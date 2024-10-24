import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class ChatRepository {
  ///
  /// 채팅방 생성
  ///
  Future<Result<void>> createChatRoom({
    required ChatRoomEntity room,
    required List<ChatQnaEntity> qnas,
    required List<BaseChatEntity> messages,
  });

  ///
  /// 채팅 면접 리스트 호출
  ///
  Future<Result<List<ChatRoomEntity>>> getChatRooms(
    InterviewType type, [
    TopicEntity? topicId,
  ]);

  ///
  /// 채팅 메세지 업데이트
  ///
  Future<Result<void>> uploadChats(
    String roomId, {
    required List<BaseChatEntity> messages,
  });

  ///
  /// 채팅 메세지 리스트 호출
  ///
  Future<Result<ChatHistoryCollectionEntity>> getChatHistory(String roomId);

  ///
  /// 채팅 문답 리스트 호출
  ///
  Future<Result<List<ChatQnaEntity>>> getChatQnas(ChatRoomEntity room);

  ///
  /// 리포트 업로드
  ///
  Future<Result<void>> uploadChatIssueReport(
    FeedbackChatEntity feedback,
    AnswerChatEntity answer,
  );
}
