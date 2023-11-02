import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/study/study.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/question_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/question_page_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_list_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_event.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class StudyQnaView extends ConsumerWidget with StudyLearningEvent {
  const StudyQnaView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(questionPageControllerProvider);
    final questionList =
        ref.watch(studyQuestionListProvider).requireValue.questionList;

    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: (value) => onQuestionPageChanged(ref),
        itemCount: questionList.length,
        itemBuilder: (context, index) => _StudyQna(
          question: questionList[index],
        ),
      ),
    );
  }
}

class _StudyQna extends StatelessWidget {
  const _StudyQna({
    super.key,
    required this.question,
  });

  final StudyQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            question.question,
            style: AppTextStyle.title1,
          ),
        ),
        HeightBox(8),
        Expanded(
          child: ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: question.answers.length,
            itemBuilder: (context, index) => _buildAnswer(
              question.answers[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswer(String answer) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.of.gray2,
          ),
        ),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final isBlur = ref.watch(questionAnswerBlurProvider);

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
  }
}
