import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/detail_page_controller_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/question_answer_blur_provider.dart';

abstract interface class _ReviewNoteDetailEvent {
  void onToggleAnswerBlur(WidgetRef ref);

  void onTapPrevQuestion(WidgetRef ref);

  void onTapNextQuestion(WidgetRef ref);
}

mixin class ReviewNoteDetailEvent implements _ReviewNoteDetailEvent {
  @override
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(questionAnswerBlurProvider.notifier).toggle();
  }

  @override
  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(detailPageControllerProvider.notifier).prev();
  }

  @override
  void onTapNextQuestion(WidgetRef ref) {
    ref.read(detailPageControllerProvider.notifier).next();
  }
}
