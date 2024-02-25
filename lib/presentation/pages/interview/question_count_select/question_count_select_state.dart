import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/select_question_count_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';

mixin class QuestionCountSelectState {
  ///
  /// 선택된 문제 개수
  ///
  int selectedQuestionCount(WidgetRef ref) =>
      ref.watch(selectedQuestionCountProvider);

  ///
  /// 라우팅 인자
  ///
  SelectQuestionCountRouteArg arg(WidgetRef ref) =>
      ref.watch(selectedQuestionCountRouteArgProvider);
}
