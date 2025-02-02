import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class ClosableSkillFilledChip extends StatelessWidget {
  const ClosableSkillFilledChip({
    super.key,
    required this.skill,
    this.onTap,
    this.height,
  });

  final SkillEntity skill;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: RoundedSkillImage(
                    imagePath: skill.imagePath,
                    scale: 1.0,
                    disableRound: true,
                    size: 16,
                  ),
                ),
                Text(
                  skill.name,
                  style: AppTextStyle.body1,
                  textAlign: TextAlign.center,
                ),
                const Gap(4),
                SvgPicture.asset(
                  Assets.iconsCircleSmallClose,
                  width: 16,
                  height: 16,
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
