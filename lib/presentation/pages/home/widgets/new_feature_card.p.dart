part of '../home_page.dart';

///
/// 첫 면접 진행 시 보여주는 메세지 카드 (일반)
///
class _NewFeatureCard extends ConsumerWidget with HomeEvent {
  const _NewFeatureCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onYoutubeFeatureCardTapped(ref);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.of.blue1,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 26, 0, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '유튜브 콘텐츠도\n테크톡에서!',
                      style: AppTextStyle.headline2.copyWith(
                        color: AppColor.of.blue3,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Text(
                          '지금 바로 학습하기',
                          style: AppTextStyle.body3.copyWith(
                            color: AppColor.of.gray6,
                          ),
                        ),
                        const Gap(2),
                        SvgPicture.asset(
                          Assets.iconsArrowRight,
                          width: 12,
                          colorFilter: ColorFilter.mode(
                            AppColor.of.gray5,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.iconsYoutubePromotionIllust,
              height: 124,
            ),
          ],
        ),
      ),
    );
  }
}
