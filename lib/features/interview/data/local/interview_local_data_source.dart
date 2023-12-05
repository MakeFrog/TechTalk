import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/data/models/interview_question_model.dart';

abstract interface class InterviewLocalDataSource {
  List<InterviewTopic> getTopics();
  Future<DateTime?> getCachedInterviewQuestionsUpdateDate(String topicId);
  Future<List<InterviewQuestionModel>?> getCachedInterviewQuestions(
      String topicId);
}
