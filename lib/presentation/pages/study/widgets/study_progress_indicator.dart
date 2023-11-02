import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/providers/current_question_page.dart';
import 'package:techtalk/presentation/pages/study/providers/study_question_list_provider.dart';

class StudyProgressIndicator extends ConsumerWidget {
  const StudyProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentQuestionPageProvider);
    final questionCount =
        ref.watch(studyQuestionListProvider).requireValue.questionList.length;

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
