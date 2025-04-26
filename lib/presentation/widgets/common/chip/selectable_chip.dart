import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/presentation/widgets/common/image/rounded_skill_image.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
    this.imagePath,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      showCheckmark: false,
      selected: isSelected,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      backgroundColor: AppColor.of.background1,
      selectedColor: AppColor.of.brand2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(
        fontFamily: 'pretendard',
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
        leadingDistribution: TextLeadingDistribution.even,
        color: isSelected ? Colors.white : AppColor.of.gray3,
        letterSpacing: -2 / 100 * 15,
        fontSize: 15,
        height: 22 / 15,
      ),
      side: BorderSide.none,
      onSelected: (selected) {
        onTap();
      },
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: RoundedSkillImage(
                imagePath: imagePath,
                size: 18,
              ),
            ),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}
