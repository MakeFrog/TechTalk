import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';

class OutlinedChip extends StatelessWidget {
  const OutlinedChip({super.key, required this.label});

  final String label;

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
      child: Text(
        label,
        style: AppTextStyle.alert1.copyWith(
          color: AppColor.of.gray5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
