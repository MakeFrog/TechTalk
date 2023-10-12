import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 회원가입 단계를 설명하는 제목과 부제목 위젯
class SignUpStepIntroduction extends StatelessWidget {
  const SignUpStepIntroduction({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PretendardTextStyle.headline1,
        ),
        const HeightBox(12),
        Text(
          subTitle,
          style: PretendardTextStyle.body1.copyWith(
            color: AppColor.of.gray4,
          ),
        ),
      ],
    );
  }
}