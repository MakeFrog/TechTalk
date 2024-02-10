import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_questions_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_event.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';

class StudyQnaView extends ConsumerWidget with StudyLearningEvent {
  const StudyQnaView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(selectedStudyTopicProvider);
    final controller = ref.watch(studyQuestionControllerProvider);
    final questions = ref.watch(studyQuestionsProvider(topic.id)).requireValue;

    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: (value) => onQuestionPageChanged(ref),
        itemCount: questions.length,
        itemBuilder: (context, index) => _StudyQna(
          question: questions[index],
        ),
      ),
    );
  }
}

class _StudyQna extends HookWidget {
  const _StudyQna({
    super.key,
    required this.question,
  });

  final QnaEntity question;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(),
        const Gap(8),
        _buildAnswers(),
      ],
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Text(
        question.question,
        style: AppTextStyle.title1,
      ),
    );
  }

  Widget _buildAnswers() {
    final answers = question.answers;
    return Expanded(
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: question.answers.length,
        itemBuilder: (context, index) {
          final answer = answers[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.of.gray2,
                ),
              ),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final isBlur = ref.watch(studyAnswerBlurProvider);

                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: isBlur ? 4 : 0,
                    sigmaY: isBlur ? 4 : 0,
                  ),
                  child: Text(
                    answer,
                    style: AppTextStyle.body2,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
