import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_controller.dart';

part 'current_study_question_index_provider.g.dart';

@riverpod
int currentStudyQuestionIndex(CurrentStudyQuestionIndexRef ref) {
  try {
    return ref.watch(studyQuestionControllerProvider).page?.round() ?? 0;
  } catch (e) {
    return 0;
  }
}
