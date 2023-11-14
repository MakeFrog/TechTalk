import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_question_page.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_list_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_event.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class StudyControllerBar extends ConsumerWidget with StudyLearningEvent {
  const StudyControllerBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentQuestionPageProvider);
    final questionCount =
        ref.watch(studyQuestionListProvider).requireValue.questions.length;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ControllerButton(
            isActive: currentPage != 0,
            label: '이전 문항',
            icon: Assets.iconsArrowLeft,
            onTap: () => onTapPrevQuestion(ref),
          ),
          _ControllerButton(
            isActive: true,
            label: '전체 문항',
            icon: Assets.iconsMenu,
            onTap: () => onTapEntireQuestion(ref),
          ),
          _ControllerButton(
            isActive: currentPage + 1 != questionCount,
            label: '다음 문항',
            icon: Assets.iconsArrowRight,
            onTap: () => onTapNextQuestion(ref),
          ),
        ],
      ),
    );
  }
}

class _ControllerButton extends StatelessWidget {
  const _ControllerButton({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.icon,
    required this.label,
  });

  final VoidCallback onTap;
  final bool isActive;
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isActive ? onTap : null,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: isActive
                ? null
                : ColorFilter.mode(
                    AppColor.of.gray2,
                    BlendMode.srcATop,
                  ),
          ),
          HeightBox(12),
          Text(
            label,
            style: AppTextStyle.alert1.copyWith(
              color: isActive ? AppColor.of.gray4 : AppColor.of.gray2,
            ),
          ),
        ],
      ),
    );
  }
}
