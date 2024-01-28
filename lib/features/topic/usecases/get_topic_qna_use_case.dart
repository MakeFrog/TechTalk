import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetTopicQnaUseCase {
  const GetTopicQnaUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Future<Result<QnaEntity>> call(
    String topicId,
    String questionId,
  ) async {
    return _topicRepository.getTopicQna(
      topicId,
      questionId,
    );
  }
}
