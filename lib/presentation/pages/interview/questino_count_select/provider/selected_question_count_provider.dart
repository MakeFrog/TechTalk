import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_question_count_provider.g.dart';

@riverpod
class SelectedQuestionCount extends _$SelectedQuestionCount {
  @override
  int build() {
    return 8;
  }

  void onCountPickerChanged(int count) {
    state = count;
  }
}
