import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/entities/qna_entity.dart';

class EntireQuestionListView extends ConsumerWidget {
  const EntireQuestionListView({
    super.key,
    required this.questions,
    required this.currentPage,
  });

  final List<QnaEntity> questions;
  final int currentPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: const BackButton(),
            title: const Text('전체 문항'),
            titleSpacing: 0,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              itemCount: questions.length,
              itemBuilder: (context, index) => _buildQuestion(
                ref,
                index,
                questions[index],
                index == currentPage,
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
    QnaEntity question,
    bool isSelected,
  ) {
    return MaterialButton(
      onPressed: () => Navigator.pop(ref.context, index),
      color: isSelected ? AppColor.of.brand1 : AppColor.of.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      shape: Border(bottom: BorderSide(color: AppColor.of.gray2, width: 0.5)),
      child: Row(
        children: [
          Text(
            '${index + 1}번',
            style: AppTextStyle.body3.copyWith(
              color: isSelected ? AppColor.of.brand3 : AppColor.of.gray3,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Text(
              question.question,
              style: AppTextStyle.body1,
            ),
          ),
        ],
      ),
    );
  }
}
