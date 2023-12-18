import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRepository {
  Result<List<Topic>> getTopics();
  Result<List<Topic>> searchTopics(String keyword);
  Future<Result<List<TopicQuestionEntity>>> getTopicQuestions(
    String topicId,
  );
  Future<Result<TopicQuestionEntity>> getTopicQuestion(
    String topicId,
    String questionId,
  );
}
