import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';

mixin class QuestionCountSelectState {
  ///
  /// 선택된 문제 개수
  ///
  int selectedQuestionCount(WidgetRef ref) =>
      ref.watch(selectedQuestionCountProvider);
}
