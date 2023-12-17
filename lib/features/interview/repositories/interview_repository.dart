import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart'
    as interview;
import 'package:techtalk/features/interview/entities/qna_entity.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

abstract interface class InterviewRepository {
  /// 문답 리스트 호출
  Future<Result<List<QnaEntity>>> getQnaList(String id);

  Future<Result<List<TopicEntity>>> getTopics();

  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });

  Future<Result<List<interview.InterviewQuestionEntity>>> getInterviewQuestions(
    String topicId,
  );
}
