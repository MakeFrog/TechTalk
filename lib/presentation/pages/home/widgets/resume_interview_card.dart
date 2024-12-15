import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

class ResumeInterviewCard extends ConsumerWidget with HomeEvent {
  const ResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      title: '이력서 면접',
      onCardTapped: () {
        onResumeCardTapped(ref);
      },
      onPlusSuffixedBtnTapped: () {
        routeToChatListPage(context, type: InterviewType.resume);
      },
      showNewBadge: true,
    );
  }
}
