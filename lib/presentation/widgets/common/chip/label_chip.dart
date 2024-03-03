import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.of.brand1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTextStyle.body1.copyWith(
          color: foregroundColor ?? AppColor.of.brand3,
        ),
      ),
    );
  }
}
