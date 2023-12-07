import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

class EntireQuestionsDialog extends StatelessWidget {
  const EntireQuestionsDialog({
    super.key,
    required this.questions,
  });

  final List<InterviewQuestionEntity> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const AppBackButton(),
        title: Text('전체 문항'),
        titleSpacing: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        // itemExtent: 68,
        itemCount: questions.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColor.of.gray2,
          height: 1,
          thickness: 1,
        ),
        itemBuilder: _buildQuestion,
      ),
    );
  }

  Widget _buildQuestion(
    BuildContext context,
    int index,
  ) {
    final question = questions[index];

    return InkWell(
      onTap: () => Navigator.pop(context, index),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}번',
              style: AppTextStyle.body3.copyWith(
                color: AppColor.of.gray3,
              ),
            ),
            const Gap(16),
            Text(
              question.question,
              style: AppTextStyle.body1,
            ),
          ],
        ),
      ),
    );
  }
}
