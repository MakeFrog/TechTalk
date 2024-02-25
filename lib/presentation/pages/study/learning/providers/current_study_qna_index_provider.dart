import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qna_controller.dart';

part 'current_study_qna_index_provider.g.dart';

@riverpod
int currentStudyQnaIndex(CurrentStudyQnaIndexRef ref) {
  try {
    return ref.watch(studyQnaControllerProvider).page?.round() ?? 0;
  } catch (e) {
    return 0;
  }
}
