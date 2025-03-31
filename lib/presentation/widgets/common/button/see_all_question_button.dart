import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';

class SeeAllQuestionButton extends StatelessWidget {
  const SeeAllQuestionButton({super.key, required this.onTap, this.padding});

  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero, // <-- 터치 영역을 고려한 padding
      child: BounceTapper(
        onTap: onTap,
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColor.of.gray1,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.iconsListedNote,
              ),
              const Gap(4),
              Text(
                '질문 고르기',
                style: AppTextStyle.alert1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
