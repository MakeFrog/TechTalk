import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRemoteDataSource {
  Future<List<TopicModel>> getTopics();
  Future<TopicModel> getTopic(String id);
  Future<List<TopicCategoryModel>> getTopicCategories();
  Future<TopicCategoryModel> getTopicCategory(String id);
  Future<List<TopicQuestionModel>> getQuestions(String topicId);
  Future<TopicQuestionModel> getQuestion(
    String topicId,
    String questionId,
  );
}
