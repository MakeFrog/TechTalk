import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_local_data_info_provider.dart';

class ResumeInterviewCard extends ConsumerWidget with HomeEvent {
  const ResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localResumeData = ref.watch(resumeLocalDataInfoProvider);

    return InterviewIndicatorCard(
      title: '이력서 면접',
      onCardTapped: () {
        // Hive에 이력서, 포폴 모두 등록 안되어있을때
        if (localResumeData.localResumePath.isEmpty &&
            localResumeData.localPortfolioPath.isEmpty) {
          routeToResumeRegistGuidePage(ref);
        } else {
          // 바로 이력서 업로드 페이지로 이동
          routeToResumeUploadPage(ref);
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
