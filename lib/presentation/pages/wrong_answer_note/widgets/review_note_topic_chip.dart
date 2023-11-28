import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';

class ReviewNoteTopicChip extends StatelessWidget {
  const ReviewNoteTopicChip({
    super.key,
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  final InterviewTopic topic;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      backgroundColor: AppColor.of.background1,
      selectedColor: AppColor.of.brand2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: AppTextStyle.body1.copyWith(
        color: isSelected ? Colors.white : AppColor.of.gray3,
      ),
      side: BorderSide.none,
      onSelected: (value) => onTap(),
      label: Text(topic.text),
    );
  }
}
