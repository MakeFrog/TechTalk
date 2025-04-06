part of '../home_page.dart';

///
/// 유튜브 면접 신규 기능을 노출하고
/// '유튜브 콘텐츠' 탭뷰로 랜딩을 유도하는 카드뷰
///
class _YoutubeContentFeatureCard extends ConsumerWidget with HomeEvent {
  const _YoutubeContentFeatureCard({super.key});

  static const InterviewType interviewType = InterviewType.youtube;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InterviewIndicatorCard(
      showNewBadge: true,
      logoPath: interviewType.logoPath,
      title: '유튜브 콘텐츠',
      subDescription: '이력서로 만든 예상 질문을 경험해 보세요!',
      onCardTapped: () {
        onYoutubeFeatureCardTapped(ref);
      },
      showPlustBtn: false,
      onPlusSuffixedBtnTapped: () {},
    );
  }
}
