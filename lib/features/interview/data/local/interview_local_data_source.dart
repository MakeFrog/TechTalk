import 'package:techtalk/features/interview/data/models/interview_question_model.dart';

abstract interface class InterviewLocalDataSource {
  Future<DateTime?> getCachedInterviewQuestionsUpdateDate(String topicId);

  Future<List<InterviewQuestionModel>?> getCachedInterviewQuestions(
      String topicId);
}
