import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/select_question_count_route_arg.dart';

part 'selected_question_count_provider.g.dart';

@Riverpod(dependencies: [selectedQuestionCountRouteArg])
class SelectedQuestionCount extends _$SelectedQuestionCount {
  @override
  int build() {
    final arg = ref.read(selectedQuestionCountRouteArgProvider);
    return arg.interviewType.isProficiency ? 0 : 4; // 4,8개
  }

  void update(int count) {
    state = count;
  }

  static int defaultPlusCount = 4;
}
