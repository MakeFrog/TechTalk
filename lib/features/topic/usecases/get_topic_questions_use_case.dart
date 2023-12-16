import 'package:techtalk/features/topic/topic.dart';

final class GetTopicQuestionsUseCase {
  const GetTopicQuestionsUseCase(
    this._topicRepository,
  );

  final TopicRepository _topicRepository;

  Future<List<TopicQuestionEntity>> call(String topicId) async {
    final questions = await _topicRepository.getTopicQuestions(topicId);

    return questions.fold(
      onSuccess: (value) => value,
      onFailure: (e) {
        throw e;
      },
    );
  }
}
