import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_question_index_provider.g.dart';

@riverpod
class CurrentQuestionIndex extends _$CurrentQuestionIndex {
  @override
  int build() => 0;

  void next() => state = state + 1;
  void prev() => state = state - 1;
  void to(int value) => state = value;
}
