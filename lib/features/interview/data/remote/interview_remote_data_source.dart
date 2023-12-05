import 'package:techtalk/features/interview/data/models/interview_qna_model.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';

abstract interface class InterviewRemoteDataSource {
  Future<List<InterviewQnaModel>> getReviewNoteQuestions({
    required String userUid,
    required String topicId,
  });

  Future<DateTime> getInterviewQuestionsUpdateDate(String topicId);
  Future<List<InterviewQuestionModel>> getInterviewQuestions(String topicId);
}
