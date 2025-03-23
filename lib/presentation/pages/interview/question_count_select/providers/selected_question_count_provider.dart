import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_question_count_provider.g.dart';

@riverpod
class SelectedQuestionCount extends _$SelectedQuestionCount {
  @override
  int build() {
    return 4; // 8개
  }

  void update(int count) {
    state = count;
  }

  static int defaultPlusCount = 4;
}
