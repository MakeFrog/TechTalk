import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class TechSetFilledChip extends StatelessWidget {
  const TechSetFilledChip({super.key, required this.item, required this.onTap});

  final TechSetEntity item;

  final void Function(TechSetEntity techSet) onTap;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: () {
        onTap(item);
      },
      child: Container(
        height: 32,
        padding: EdgeInsets.only(left: item is SkillSet ? 8 : 10, right: 10),
        decoration: BoxDecoration(
          color: AppColor.of.background1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item is SkillSet)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: RoundedSkillImage(
                  size: 16,
                  borderRadius: BorderRadius.circular(3),
                  imagePath: (item as SkillSet).value.imagePath,
                ),
              ),
            Text(
              item.name(),
              style: AppTextStyle.body1,
            ),
          ],
        ),
      ),
    );
  }
}
