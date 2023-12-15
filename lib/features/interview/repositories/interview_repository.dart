import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart'
    as interview;

abstract interface class InterviewRepository {
  Result<List<InterviewTopic>> getTopics();

  Future<Result<List<InterviewQnAEntity>>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });

  Future<Result<List<interview.InterviewQuestionEntity>>> getInterviewQuestions(
    String topicId,
  );
}
