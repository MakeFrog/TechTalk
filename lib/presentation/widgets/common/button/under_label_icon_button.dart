import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class UnderLabelIconButton extends StatelessWidget {
  const UnderLabelIconButton({
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
          Gap(12),
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
