import 'package:techtalk/features/topic/data/models/topic_question_model.dart';

abstract interface class TopicLocalDataSource {
  Future<List<TopicQuestionModel>?> getQuestions(String topicId);

  Future<TopicQuestionModel?> getQuestion(
    String topicId,
    String questionId,
  );
}
