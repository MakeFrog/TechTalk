import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';

class ClosableRectFilledChip extends StatelessWidget {
  const ClosableRectFilledChip({
    super.key,
    required this.label,
    this.onTap,
    this.height,
  });

  final String label;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.of.brand2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: height ?? 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Row(
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.body1.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Gap(2),
                SvgPicture.asset(
                  Assets.iconsRoundedCloseBlue,
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
