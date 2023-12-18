import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wrong_answer_blur_provider.g.dart';

@riverpod
class WrongAnswerBlur extends _$WrongAnswerBlur {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
