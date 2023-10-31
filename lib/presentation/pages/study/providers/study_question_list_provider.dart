import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/study/study.dart';

part 'study_question_list_provider.g.dart';

@riverpod
Future<StudyQuestionListEntity> studyQuestionList(
  StudyQuestionListRef ref,
) async {
  return getStudyQuestionListUseCase();
}
