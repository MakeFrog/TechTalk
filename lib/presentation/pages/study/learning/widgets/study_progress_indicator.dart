import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';

class StudyProgressIndicator extends ConsumerWidget with LearningDetailState {
  const StudyProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${currentIndex(ref) + 1}',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.brand3,
            ),
          ),
          Text(
            ' / ${qnas(ref).length} ${tr(LocaleKeys.undefined_question)}',
            style: AppTextStyle.body3.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
        ],
      ),
    );
  }
}
