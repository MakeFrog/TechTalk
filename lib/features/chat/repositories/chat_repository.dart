import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_list_item_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_question_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/message_entity.dart';

abstract interface class ChatRepository {
  /// 채팅 메세지 리스트 호출
  Future<Result<List<MessageEntity>>> getChatHistory(String roomId);

  /// 모범답안 리스트 호출
  Future<Result<List<String>>> getIdealAnswers(
    InterviewQuestionEntity questionId,
  );

  /// 랜던 문제 호출
  Future<Result<InterviewQuestionEntity>> getRandomQuestion(String categoryId);

  /// 채팅 면접 리스트 호출
  Future<Result<List<ChatRoomListItemEntity>>> getChatRoomList(String topicId);
}
