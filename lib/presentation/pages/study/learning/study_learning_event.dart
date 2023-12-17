import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/providers/study/current_study_question_index_provider.dart';
import 'package:techtalk/presentation/providers/study/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/providers/study/study_question_controller.dart';

abstract interface class _StudyLearningEvent {
  void onToggleAnswerBlur(WidgetRef ref);

  void onQuestionPageChanged(WidgetRef ref);

  void onTapPrevQuestion(WidgetRef ref);

  Future<void> onTapEntireQuestion(WidgetRef ref);

  void onTapNextQuestion(WidgetRef ref);
}

mixin class StudyLearningEvent implements _StudyLearningEvent {
  @override
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(studyAnswerBlurProvider.notifier).toggle();
  }

  @override
  void onQuestionPageChanged(WidgetRef ref) {
    ref.invalidate(currentStudyQuestionIndexProvider);
  }

  @override
  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(studyQuestionControllerProvider.notifier).prev();
  }

  @override
  Future<void> onTapEntireQuestion(WidgetRef ref) async {
    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EntireQuestionListView(),
      ),
    );

    if (selectedQuestionIndex != null) {
      ref
          .read(studyQuestionControllerProvider)
          .jumpToPage(selectedQuestionIndex);
    }
  }

  @override
  void onTapNextQuestion(WidgetRef ref) {
    ref.read(studyQuestionControllerProvider.notifier).next();
  }
}
