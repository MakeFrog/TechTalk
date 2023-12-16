import 'package:techtalk/features/interview_new/data/models/interview_question_model.dart';

abstract interface class InterviewLocalDataSource {
  Future<DateTime?> getUpdateDateOfTopic(String topicId);
  Future<List<InterviewQuestionModel>?> getQuestionsOfTopic(String topicId);
}
