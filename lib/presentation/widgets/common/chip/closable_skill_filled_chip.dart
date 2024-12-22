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
    return Material(
      color: AppColor.of.brand2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: height ?? 34,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Row(
              children: [
                RoundedSkillImage(
                  imagePath: skill.imagePath,
                ),
                const Gap(6),
                Text(
                  skill.name,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.newBody.copyWith(
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
