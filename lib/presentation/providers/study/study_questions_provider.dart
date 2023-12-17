import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';

part 'study_questions_provider.g.dart';

@Riverpod()
class StudyQuestions extends _$StudyQuestions {
  @override
  FutureOr<List<TopicQuestionEntity>> build() async {
    final topic = ref.watch(selectedStudyTopicProvider)!;

    return getTopicQuestionsUseCase(topic.id);
  }
}
