import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/topic/topic.dart';

final class GetTopicQuestionsUseCase {
  const GetTopicQuestionsUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Future<Result<List<TopicQuestionEntity>>> call(String topicId) async {
    final questions = await _topicRepository.getTopicQuestions(topicId);

    return questions;
  }
}
