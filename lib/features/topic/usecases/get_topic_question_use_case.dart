import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetTopicQuestionUseCase {
  const GetTopicQuestionUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Future<Result<TopicQuestionEntity>> call(
    String topicId,
    String questionId,
  ) async {
    final question = await _topicRepository.getTopicQuestion(
      topicId,
      questionId,
    );

    return question;
  }
}
