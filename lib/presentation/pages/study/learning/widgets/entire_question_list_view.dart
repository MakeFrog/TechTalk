import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_questions_provider.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

class EntireQuestionListView extends ConsumerWidget {
  const EntireQuestionListView({
    super.key,
    required this.topic,
  });

  final TopicEntity topic;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(studyQuestionsProvider(topic.id)).requireValue;

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
        itemBuilder: (context, index) => _buildQuestion(
          ref,
          index,
          questions[index],
        ),
      ),
    );
  }

  Widget _buildQuestion(
    WidgetRef ref,
    int index,
    TopicQuestionEntity question,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(ref.context, index),
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
            Expanded(
              child: Text(
                question.question,
                style: AppTextStyle.body1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
