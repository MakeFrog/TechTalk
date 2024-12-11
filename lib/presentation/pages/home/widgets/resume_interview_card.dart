import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

class ResumeInterviewCard extends ConsumerWidget {
  const ResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      title: '이력서 면접',
      onCardTapped: () {},
      onPlusSuffixedBtnTapped: () {},
      showNewBadge: true,
    );
  }
}
