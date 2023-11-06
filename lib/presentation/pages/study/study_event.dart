import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/study/providers/current_question_page.dart';
import 'package:techtalk/presentation/pages/study/providers/question_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/providers/question_page_controller.dart';
import 'package:techtalk/presentation/pages/study/widgets/entire_question_list_view.dart';

abstract interface class _StudyEvent {
  void onToggleAnswerBlur(WidgetRef ref);

  void onQuestionPageChanged(WidgetRef ref);

  void onTapPrevQuestion(WidgetRef ref);

  Future<void> onTapEntireQuestion(WidgetRef ref);

  void onTapNextQuestion(WidgetRef ref);
}

mixin class StudyEvent implements _StudyEvent {
  @override
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(questionAnswerBlurProvider.notifier).toggle();
  }

  @override
  void onQuestionPageChanged(WidgetRef ref) {
    ref.invalidate(currentQuestionPageProvider);
  }

  @override
  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(questionPageControllerProvider.notifier).prev();
  }

  @override
  Future<void> onTapEntireQuestion(WidgetRef ref) async {
    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const EntireQuestionListView(),
      ),
    );

    if (selectedQuestionIndex != null) {
      ref
          .read(questionPageControllerProvider)
          .jumpToPage(selectedQuestionIndex);
    }
  }

  @override
  void onTapNextQuestion(WidgetRef ref) {
    ref.read(questionPageControllerProvider.notifier).next();
  }
}
