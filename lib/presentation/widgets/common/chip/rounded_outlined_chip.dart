import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class RoundedOutlinedChip extends StatelessWidget {
  const RoundedOutlinedChip({super.key, required this.label, this.imagePath});

  final String label;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColor.of.gray1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: RoundedSkillImage(
                imagePath: imagePath,
                scale: 1.0,
                disableRound: true,
                size: 16,
              ),
            ),
          Text(
            label,
            style: AppTextStyle.body2.copyWith(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
