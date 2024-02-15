import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/button/icon_flash_area_button.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconFlashAreaButton.assetIcon(
            iconPath: icon,
            size: 24,
            activatedColor: AppColor.of.gray4,
            enabledColor: AppColor.of.gray2,
            onIconTapped: isActive ? onTap : null,
          ),
          const Gap(12),
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
