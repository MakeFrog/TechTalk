import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/providers/study/study_question_controller.dart';
import 'package:techtalk/presentation/providers/study/study_questions_provider.dart';

class StudyProgressIndicator extends ConsumerWidget {
  const StudyProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentQuestionPageProvider);
    final questionCount = ref.watch(studyQuestionsProvider).requireValue.length;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${currentPage + 1}',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.brand3,
            ),
          ),
          Text(
            ' / $questionCount 문항',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
        ],
      ),
    );
  }
}
