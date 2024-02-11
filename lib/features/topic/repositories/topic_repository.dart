import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicRepository {
  Future<void> initStaticData();

  Result<List<TopicCategoryEntity>> getTopicCategories();

  Result<TopicCategoryEntity> getTopicCategory(String id);

  Future<Result<List<QnaEntity>>> getTopicQnas(
    String topicId,
  );

  Future<Result<QnaEntity>> getTopicQna(
    String topicId,
    String questionId,
  );

  Future<Result<void>> updateWrongAnswer(ChatQnaEntity chatQna);
}
