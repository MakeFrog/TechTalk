import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicLocalDataSource {
  Future<List<TopicCategoryModel>> getTopicCategories();
  Future<List<TopicQnaModel>?> getQnas(String topicId);

  Future<TopicQnaModel?> getQna(
    String topicId,
    String questionId,
  );
}
