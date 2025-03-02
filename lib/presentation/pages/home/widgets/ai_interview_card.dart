import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

///
/// AI 면접 카드
///
class AiInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const AiInterviewCard({super.key});

  static const InterviewType interviewType = InterviewType.ai;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      showNewBadge: true,
      logoPath: interviewType.logoPath,
      title: 'AI 면접',
      subDescription: !(user(ref)?.hasPracticalInterviewRecord ?? false)
          ? tr(LocaleKeys.home_practicalInterviewDesc)
          : null,
      onCardTapped: () {
        onPracticalCardTapped(ref);
      },
      onPlusSuffixedBtnTapped: () {
        routeToTopicSelectPage(
          context,
          type: InterviewType.commonPracticalTopic,
        );
      },
    );
  }
}
