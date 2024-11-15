import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_result.dart';

class InterviewCountResultIndicator extends StatelessWidget {
  const InterviewCountResultIndicator({
    super.key,
    required this.result,
    required this.totalCount,
    required this.correctAnswerCount,
  });

  final InterviewResult result;
  final int totalCount;
  final int correctAnswerCount;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: result.isPassed ? AppColor.of.blue1 : AppColor.of.red1,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Align(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$correctAnswerCount/',
                ),
                TextSpan(
                  text: '$totalCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              style: AppTextStyle.title1.copyWith(
                color: result.isPassed ? AppColor.of.brand3 : AppColor.of.red2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
