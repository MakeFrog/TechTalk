import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetTopicUseCase {
  GetTopicUseCase(this._topicRepository);

  final TopicRepository _topicRepository;

  Result<TopicEntity> call(String id) {
    return _topicRepository.getTopic(id);
  }
}
