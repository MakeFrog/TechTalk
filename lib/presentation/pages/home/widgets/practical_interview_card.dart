import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';

class PracticalInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const PracticalInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      title: tr(LocaleKeys.home_practicalInterview),
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
