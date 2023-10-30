import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

final _qnaAnimationDuration = 400.ms;
const _qnaAnimationCurves = Curves.easeOutQuint;

class StudyControllerBar extends StatelessWidget {
  const StudyControllerBar({
    super.key,
    required this.controller,
    required this.currentQnaIndex,
    required this.itemCount,
  });

  final PageController controller;
  final int currentQnaIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 18.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ControllerButton(
            isActive: currentQnaIndex != 0,
            label: '이전 문항',
            icon: Assets.iconsArrowLeft,
            onTap: () {
              controller.previousPage(
                duration: _qnaAnimationDuration,
                curve: _qnaAnimationCurves,
              );
            },
          ),
          _ControllerButton(
            isActive: true,
            label: '전체 문항',
            icon: Assets.iconsMenu,
            onTap: () async {
              final selectedQuestionIndex = await Navigator.push<int>(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => EntireQuestionListView(
                    itemCount: itemCount,
                  ),
                ),
              );

              if (selectedQuestionIndex != null) {
                controller.jumpToPage(selectedQuestionIndex);
              }
            },
          ),
          _ControllerButton(
            isActive: currentQnaIndex != itemCount,
            label: '다음 문항',
            icon: Assets.iconsArrowRight,
            onTap: () {
              controller.nextPage(
                duration: _qnaAnimationDuration,
                curve: _qnaAnimationCurves,
              );
            },
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
            width: 24.r,
            height: 24.r,
            colorFilter: isActive
                ? null
                : ColorFilter.mode(
                    AppColor.of.gray2,
                    BlendMode.srcATop,
                  ),
          ),
          HeightBox(12.h),
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
