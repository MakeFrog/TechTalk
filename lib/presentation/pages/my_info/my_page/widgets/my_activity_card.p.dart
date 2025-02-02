part of '../my_page.dart';

class _MyActivityCard extends ConsumerWidget with MyPageEvent {
  const _MyActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            tr(LocaleKeys.myInfo_myActivity),
            style: AppTextStyle.headline3,
          ),
        ),
        const Gap(12),
        BounceTapper(
          onTap: () {
            onMyYoutubeBoardSectionTapped(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.of.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr(LocaleKeys.common_content),
                      style: AppTextStyle.title2,
                    ),
                    SvgPicture.asset(
                      Assets.iconsNewRightArrow,
                    ),
                  ],
                ),
                const Gap(4),
                Text(
                  tr(LocaleKeys.myInfo_contentDescription),
                  style: AppTextStyle.body3.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
