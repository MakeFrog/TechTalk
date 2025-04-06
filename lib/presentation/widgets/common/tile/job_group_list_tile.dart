import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/presentation/widgets/common/animated/animated_size_and_fade.dart';

class JobGroupListTile extends StatelessWidget {
  const JobGroupListTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onItemTapped,
  });

  final JobGroupEntity item;
  final bool isSelected;
  final void Function(JobGroupEntity item) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: () {
        onItemTapped(item);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52,
        width: double.infinity,
        color: isSelected ? AppColor.of.background1 : AppColor.of.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: AppTextStyle.body2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 16,
              width: 16,
              child: AnimatedSizeAndFade.showHide(
                fadeDuration: const Duration(milliseconds: 200),
                show: isSelected,
                child: SvgPicture.asset(
                  Assets.iconsDarkCheckBox,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
