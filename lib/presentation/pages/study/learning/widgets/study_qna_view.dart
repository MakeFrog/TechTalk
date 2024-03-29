import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:techtalk/presentation/pages/study/learning/learning_detail_event.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';

class StudyQnaView extends ConsumerWidget
    with LearningDetailState, LearningDetailEvent {
  const StudyQnaView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 82),
        child: PageView.builder(
          controller: controller(ref),
          onPageChanged: (value) => onQuestionPageChanged(ref),
          itemCount: qnas(ref).length,
          itemBuilder: (context, index) => _StudyQna(
            question: qnas(ref)[index],
          ),
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
