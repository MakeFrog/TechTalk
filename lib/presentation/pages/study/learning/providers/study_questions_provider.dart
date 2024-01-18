import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'study_questions_provider.g.dart';

@riverpod
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<QnaEntity>> build(String topicId) async {
    return (await getTopicQnasUseCase(topicId)).getOrThrow();
  }
}
