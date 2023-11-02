import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class RoundedRectFilledChip extends StatelessWidget {
  const RoundedRectFilledChip({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.of.brand2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: AppTextStyle.body1.copyWith(
                  color: Colors.white,
                ),
              ),
              WidthBox(2),
              SvgPicture.asset(
                Assets.iconsRoundedCloseThick,
                width: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
