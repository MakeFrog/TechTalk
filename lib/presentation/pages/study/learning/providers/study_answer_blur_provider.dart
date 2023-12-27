import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_answer_blur_provider.g.dart';

@Riverpod(keepAlive: true)
class StudyAnswerBlur extends _$StudyAnswerBlur {
  @override
  bool build() => false;

  void toggle() => state = !state;
}
