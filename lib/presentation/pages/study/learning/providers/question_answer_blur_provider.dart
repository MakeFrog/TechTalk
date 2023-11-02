import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_answer_blur_provider.g.dart';

@riverpod
class QuestionAnswerBlur extends _$QuestionAnswerBlur {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
