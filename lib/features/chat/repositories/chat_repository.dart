import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';

abstract interface class ChatRepository {
  /// 채팅 리스트 호출
  Future<Result<List<ChatEntity>>> getChatList(String roomId);

  /// 면접 질문 리스트 QnA 리스트 호출
  Future<List<InterviewQnAEntity>> getInitialQuestions(String topicId);

  /// 진행중인 문답 리스트 호출
  Future<Result<List<InterviewQnAEntity>>> getOngoingQnaList(String roomId);

  /// 모범답안 리스트 호출
  Future<Result<List<String>>> getIdealAnswers(String questionId);
}
