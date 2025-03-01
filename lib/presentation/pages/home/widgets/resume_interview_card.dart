import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

class ResumeInterviewCard extends ConsumerWidget with HomeEvent, HomeState {
  const ResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      title: '이력서 면접',
      onCardTapped: () {
        if (hasData(ref)) {
          debugPrint('현재 데이터 존재');
          routeToResumeUploadPage(ref);
        } else {
          debugPrint('현재 데이터 없음');
          routeToResumeRegistGuidePage(ref);
        }

        // TODO: 면접 시작시 적용하기(yundal)
        // routeToResumeChatList(ref);
      },
      onPlusSuffixedBtnTapped: () {
        routeToChatListPage(context, type: InterviewType.resume);
      },
      showNewBadge: true,
    );
  }
}
