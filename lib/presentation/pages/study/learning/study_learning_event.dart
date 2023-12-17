import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/interview/entities/qna_entity.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/question_page_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/providers/study/study_answer_blur_provider.dart';

abstract interface class _StudyLearningEvent {
  void onToggleAnswerBlur(WidgetRef ref);

  void onQuestionPageChanged(WidgetRef ref);

  void onTapPrevQuestion(WidgetRef ref);

  Future<void> onTapEntireQuestion(
    WidgetRef ref, {
    required List<QnaEntity> questions,
    required int currenPage,
  });

  void onTapNextQuestion(WidgetRef ref);
}

mixin class StudyLearningEvent implements _StudyLearningEvent {
  @override
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(studyAnswerBlurProvider.notifier).toggle();
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
  Future<void> onTapEntireQuestion(
    WidgetRef ref, {
    required List<QnaEntity> questions,
    required int currenPage,
  }) async {
    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EntireQuestionListView(
          questions: questions,
          currentPage: currenPage,
        ),
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
