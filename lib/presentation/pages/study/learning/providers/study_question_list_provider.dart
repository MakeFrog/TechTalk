import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/study/study.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/selected_study_topic_provider.dart';

part 'study_question_list_provider.g.dart';

@riverpod
Future<StudyQuestionListEntity> studyQuestionList(
  StudyQuestionListRef ref,
) async {
  final topic = ref.watch(selectedStudyTopicProvider);

  final result = await getStudyQuestionListUseCase('react');

  return result.getOrThrow();
}
