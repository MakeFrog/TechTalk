import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/entities/topic.enum.dart';

abstract interface class TopicRepository {
  Result<List<Topic>> getTopics();

  Result<List<Topic>> searchTopics(String keyword);
}
