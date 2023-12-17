import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_interview_question_count_provider.g.dart';

@riverpod
class SelectedInterviewQuestionCount extends _$SelectedInterviewQuestionCount {
  @override
  int build() => 8;

  void onCountPickerChanged(int count) => state = count;
}
