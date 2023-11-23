import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class QnaCountIndicator extends StatelessWidget {
  const QnaCountIndicator(
      {Key? key,
      required this.totalQuestionCount,
      required this.completedQuestionCount})
      : super(key: key);

  final int totalQuestionCount;
  final int completedQuestionCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.of.background1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$completedQuestionCount/$totalQuestionCount',
        style: AppTextStyle.alert1.copyWith(color: AppColor.of.gray6),
      ),
    );
  }
}
