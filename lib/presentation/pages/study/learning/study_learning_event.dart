import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_question_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';

mixin class StudyLearningEvent {
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(studyAnswerBlurProvider.notifier).toggle();
  }

  void onQuestionPageChanged(WidgetRef ref) {
    ref.invalidate(currentStudyQuestionIndexProvider);
  }

  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(studyQuestionControllerProvider.notifier).prev();
  }

  Future<void> onTapEntireQuestion(WidgetRef ref) async {
    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EntireQuestionListView(
          topic: ref.read(selectedStudyTopicProvider),
        ),
      ),
    );

    if (selectedQuestionIndex != null) {
      ref
          .read(studyQuestionControllerProvider)
          .jumpToPage(selectedQuestionIndex);
    }
  }

  void onTapNextQuestion(WidgetRef ref) {
    ref.read(studyQuestionControllerProvider.notifier).next();
  }
}
