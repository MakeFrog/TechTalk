import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';

mixin class ReviewNoteDetailEvent {
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(wrongAnswerBlurProvider.notifier).toggle();
  }
}
