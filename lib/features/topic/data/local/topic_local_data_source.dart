import 'package:techtalk/features/topic/topic.dart';

abstract interface class TopicLocalDataSource {
  Future<List<TopicQnaEntity>?> getQnas(String topicId);

  Future<TopicQnaEntity?> getQna(
    String topicId,
    String questionId,
  );
}
