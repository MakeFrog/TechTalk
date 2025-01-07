import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

///
/// 이력서 기발 면접 질문 > 소프트 or 하드 스킬 여부를 나타내는 chip
///
class ResumeQuestionTypeChip extends StatelessWidget {
  const ResumeQuestionTypeChip({super.key, required this.type, this.margin});

  final ResumeQuestionType type;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColor.of.white,
        border: Border.all(
          color: AppColor.of.gray2,
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        type.label,
        style: AppTextStyle.body3.copyWith(
          color: AppColor.of.gray4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
