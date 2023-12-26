import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRemoteDataSource {
  Future<List<TopicModel>> getTopics();
  Future<List<TopicCategoryModel>> getTopicCategories();
  Future<List<TopicQnaModel>> getQnas(String topicId);
  Future<TopicQnaModel> getQna(
    String topicId,
    String questionId,
  );
}
