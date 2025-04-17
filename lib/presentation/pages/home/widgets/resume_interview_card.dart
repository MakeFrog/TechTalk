import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

class ResumeInterviewCard extends ConsumerWidget with HomeEvent, HomeState {
  const ResumeInterviewCard({super.key});

  static const InterviewType type = InterviewType.resume;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      title: '이력서 면접',
      subDescription: '이력서로 만든 예상 질문을 경험해 보세요!',
      onCardTapped: () =>
          routeToChatListPage(context, type: InterviewType.resume),
      //routeToResumeChatList(ref);
      onPlusSuffixedBtnTapped: () => routeToResumeUploadPage(ref),
      //  routeToChatListPage(context, type: InterviewType.resume);
      logoPath: type.logoPath,
      showNewBadge: true,
    );
  }
}
