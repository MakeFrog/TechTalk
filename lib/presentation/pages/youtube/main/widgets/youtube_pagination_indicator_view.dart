import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/index.dart';

class YoutubePaginationIndicatorView extends StatelessWidget {
  const YoutubePaginationIndicatorView(
      {super.key,
      required this.title,
      required this.description,
      required this.btnText,
      required this.onBtnTapped});

  final String title;
  final String description;
  final String btnText;
  final VoidCallback onBtnTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 214),
        Text(
          title,
          style: AppTextStyle.title1,
        ),
        const Gap(8),
        Text(
          description,
          style: AppTextStyle.body2.copyWith(
            color: AppColor.of.gray3,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        FilledButton(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
          ),
          onPressed: onBtnTapped,
          child: Text(
            btnText,
          ),
        ),
        const Spacer(flex: 240),
      ],
    );
  }
}
