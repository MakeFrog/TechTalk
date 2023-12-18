import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/providers/wrong_answer/wrong_answer_blur_provider.dart';

abstract interface class _ReviewNoteDetailEvent {
  void onToggleAnswerBlur(WidgetRef ref);
}

mixin class ReviewNoteDetailEvent implements _ReviewNoteDetailEvent {
  @override
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(wrongAnswerBlurProvider.notifier).toggle();
  }
}
