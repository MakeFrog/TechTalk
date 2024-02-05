import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator(
      {super.key,
      this.errorCode,
      required this.subTitle,
      required this.title,
      this.padding});

  final int? errorCode;
  final String subTitle;
  final String title;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: AppTextStyle.headline2,
          ),
          const Gap(8),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                if (errorCode != null) TextSpan(text: '[${errorCode!}] '),
                TextSpan(text: subTitle),
              ],
            ),
          ),
          const Gap(16),
          SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
          ),
        ],
      ),
    );
  }
}
