import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRemoteDataSource {
  Future<List<TopicEntity>> getTopics();
  Future<List<TopicCategoryEntity>> getTopicCategories();
  Future<List<TopicQnaEntity>> getQnas(String topicId);
  Future<TopicQnaEntity> getQna(
    String topicId,
    String questionId,
  );
}
