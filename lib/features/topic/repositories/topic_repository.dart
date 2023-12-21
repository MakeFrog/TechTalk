import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRepository {
  Future<void> initCache();
  Result<List<TopicEntity>> getTopics();
  Result<TopicEntity> getTopic(String id);
  Result<List<TopicCategoryEntity>> getTopicCategories();
  Result<TopicCategoryEntity> getTopicCategory(String id);
  Future<Result<List<TopicQuestionEntity>>> getTopicQuestions(
    String topicId,
  );
  Future<Result<TopicQuestionEntity>> getTopicQuestion(
    String topicId,
    String questionId,
  );
}
