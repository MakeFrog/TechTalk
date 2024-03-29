import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';

/// 회원가입 단계를 설명하는 제목과 부제목 위젯
class SignUpStepIntroMessage extends StatelessWidget {
  const SignUpStepIntroMessage({
    super.key,
    required this.title,
    this.subTitle,
  });

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          if (subTitle != null)
            Text(
              subTitle!,
              style: AppTextStyle.body1.copyWith(
                color: AppColor.of.gray4,
              ),
            ),
        ],
      ),
    );
  }
}
