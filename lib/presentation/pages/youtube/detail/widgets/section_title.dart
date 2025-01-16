import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.iconPath});

  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        const Gap(2),
        Text(
          title,
          style: AppTextStyle.headline2,
        ),
      ],
    );
  }
}
