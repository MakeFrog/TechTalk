import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'study_questions_provider.g.dart';

@riverpod
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<TopicQuestionEntity>> build(String topicId) async {
    return getTopicQuestionsUseCase(topicId);
  }
}
