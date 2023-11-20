import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_qna_entity.dart';
import 'package:techtalk/presentation/pages/review_note/review_note_detail_page.dart';

class ReviewQuestionListView extends StatelessWidget {
  const ReviewQuestionListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class ReviewQuestionListItem extends ConsumerWidget {
  const ReviewQuestionListItem({
    super.key,
    required this.index,
    required this.question,
  });

  final int index;
  final InterviewQnAEntity question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewNoteDetailPage(page: index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Text(
          question.question,
          style: AppTextStyle.body1,
        ),
      ),
    );
  }
}
