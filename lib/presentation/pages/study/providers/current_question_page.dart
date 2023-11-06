import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/study/providers/question_page_controller.dart';

part 'current_question_page.g.dart';

@riverpod
int currentQuestionPage(CurrentQuestionPageRef ref) {
  try {
    return ref.watch(questionPageControllerProvider).page?.round() ?? 0;
  } catch (e) {
    return 0;
  }
}
