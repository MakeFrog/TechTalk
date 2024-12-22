import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

///
/// 텍스트 카드뷰
/// 텍스트 크기에 맞게 카드뷰의 크기가 설정됨
///

class RoundedSkillFilledChip extends StatelessWidget {
  const RoundedSkillFilledChip(
      {Key? key, required this.skill, this.margin, this.color})
      : super(key: key);

  final SkillEntity skill;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: margin ?? EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColor.of.gray1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedSkillImage(
            imagePath: skill.imagePath,
          ),
          const Gap(6),
          Text(
            skill.name,
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray5,
            ),
          ),
        ],
      ),
    );
  }
}
