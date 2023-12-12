import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/entities/interview_question_entity.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class EntireQuestionListView extends ConsumerWidget {
  const EntireQuestionListView({
    super.key,
    required this.questions,
  });

  final List<InterviewQuestionEntity> questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: const BackButton(),
            title: Text('전체 문항'),
            titleSpacing: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
              itemExtent: 68,
              itemCount: questions.length,
              itemBuilder: (context, index) => _buildQuestion(
                ref,
                index,
                questions[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(
    WidgetRef ref,
    int index,
    InterviewQuestionEntity question,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(ref.context, index),
      child: Padding(
        padding: EdgeInsets.symmetric(
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
            WidthBox(16),
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
