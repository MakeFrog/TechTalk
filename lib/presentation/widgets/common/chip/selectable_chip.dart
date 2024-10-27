import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.label});

  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      selected: isSelected,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
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
        letterSpacing: -0.02 / 100 * 15,
        fontSize: 15,
        height: 22 / 15,
      ),
      side: BorderSide.none,
      onSelected: (_) {
        onTap();
      },
      label: Text(
        label,
      ),
    );
  }
}
