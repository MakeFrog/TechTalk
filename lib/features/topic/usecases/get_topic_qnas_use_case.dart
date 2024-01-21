import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetTopicQnasUseCase {
  const GetTopicQnasUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Future<Result<List<QnaEntity>>> call(String topicId) async {
    return _topicRepository.getTopicQnas(topicId);
  }
}
