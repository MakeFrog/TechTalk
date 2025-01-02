import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/content_filter_category_type.enum.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_page.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

///
/// [YoutubeMainPage] 상단 카테고리 슬라이드 바에서 사용되는 chip
///
class SelectableCategoryChip extends StatelessWidget {
  const SelectableCategoryChip({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.item,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final YoutubeContentCategory item;

  ContentFilterCategoryType get type => item.type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ChoiceChip(
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            labelPadding: item.type.isSkill
                ? const EdgeInsets.only(
                    left: 8,
                    right: 10,
                  )
                : const EdgeInsets.symmetric(horizontal: 12),
            showCheckmark: false,
            selected: isSelected,
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            backgroundColor: AppColor.of.white,
            selectedColor: type.isAll ? AppColor.of.gray6 : AppColor.of.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: Colors.white,
            labelStyle: TextStyle(
              fontFamily: 'pretendard',
              fontWeight: type.isAll ? FontWeight.w700 : FontWeight.w600,
              leadingDistribution: TextLeadingDistribution.even,
              color: type.isAll
                  ? (isSelected ? Colors.white : AppColor.of.gray3)
                  : (isSelected ? AppColor.of.gray6 : AppColor.of.gray3),
              letterSpacing: -2 / 100 * 15,
              fontSize: 15,
              height: 22 / 15,
            ),
            side: BorderSide.none,
            onSelected: (_) {
              onTap();
            },
            label: Row(
              children: [
                if (item.type.isSkill)
                  Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: RoundedSkillImage(
                        imagePath: item.imagePath,
                        scale: 1.0,
                        disableRound: true,
                        size: 16,
                      )),
                Text(
                  item.name,
                ),
              ],
            ),
          ),
          if (!type.isAll)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 120,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    border: Border.all(
                      width: 2,
                      color:
                          isSelected ? AppColor.of.gray6 : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
