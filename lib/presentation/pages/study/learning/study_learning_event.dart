import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/providers/study/current_question_index_provider.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/providers/study/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/providers/study/study_questions_provider.dart';

abstract interface class _StudyLearningEvent {
  void onToggleAnswerBlur(WidgetRef ref);

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
  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(currentQuestionIndexProvider.notifier).prev();
  }

  @override
  Future<void> onTapEntireQuestion(WidgetRef ref) async {
    final topicId = ref.read(selectedStudyTopicProvider).id;
    final questions = ref.read(studyQuestionsProvider(topicId)).requireValue;

    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EntireQuestionsDialog(
          questions: questions,
        ),
      ),
    );

    if (selectedQuestionIndex != null) {
      ref.read(currentQuestionIndexProvider.notifier).to(selectedQuestionIndex);
    }
  }

  @override
  void onTapNextQuestion(WidgetRef ref) {
    ref.read(currentQuestionIndexProvider.notifier).next();
  }
}
