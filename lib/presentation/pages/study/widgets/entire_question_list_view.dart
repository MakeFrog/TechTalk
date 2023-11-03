import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/study/study.dart';
import 'package:techtalk/presentation/pages/study/providers/study_question_list_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class EntireQuestionListView extends ConsumerWidget {
  const EntireQuestionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionList =
        ref.watch(studyQuestionListProvider).requireValue.questionList;

    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: const BackButton(),
            title: Text(
              '전체 문항',
              style: AppTextStyle.headline2,
            ),
            titleSpacing: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              itemExtent: 68.h,
              itemCount: questionList.length,
              itemBuilder: (context, index) => _buildQuestion(
                ref,
                index,
                questionList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(
    WidgetRef ref,
    int index,
    StudyQuestionEntity question,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(ref.context, index),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 24.h,
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}번',
              style: AppTextStyle.body3.copyWith(
                color: AppColor.of.gray3,
              ),
            ),
            WidthBox(16.w),
            Text(
              question.question,
              style: AppTextStyle.body1,
            ),
          ],
        ),
      ),
    );
  }
}
