import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/entities/interview_question_entity.dart';

abstract interface class ChatRepository {
  /// 채팅 리스트 호출
  Future<Result<List<ChatEntity>>> getChatList(String roomId);

  /// 모범답안 리스트 호출
  Future<Result<List<String>>> getIdealAnswers(
    InterviewQuestionEntity questionId,
  );

  /// 랜던 문제 호출
  Future<Result<InterviewQuestionEntity>> getRandomQuestion(String categoryId);
}
