import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_answer_blur_provider.g.dart';

@riverpod
class StudyAnswerBlur extends _$StudyAnswerBlur {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
