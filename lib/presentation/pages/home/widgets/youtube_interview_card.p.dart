part of '../home_page.dart';

///
/// 유튜브 면접 카드
///
class _YoutubeInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const _YoutubeInterviewCard({super.key});

  static const InterviewType interviewType = InterviewType.youtube;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      showNewBadge: true,
      logoPath: interviewType.logoPath,
      title: tr(LocaleKeys.youtubeInterview_title),
      subDescription: tr(LocaleKeys.youtubeInterview_subDescription),
      onCardTapped: () {
        onYoutubeFeatureCardTapped(ref);
      },
      onPlusSuffixedBtnTapped: () {
        onYoutubeFeatureCardTapped(ref);
      },
    );
  }
}
