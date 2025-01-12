part of '../my_page.dart';

class _MyActivityCard extends ConsumerWidget {
  const _MyActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '내 활동',
            style: AppTextStyle.headline3,
          ),
        ),
        const Gap(12),
        BounceTapper(
          onTap: () {},
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
                      '내 영상 학습',
                      style: AppTextStyle.title2,
                    ),
                    SvgPicture.asset(
                      Assets.iconsNewRightArrow,
                    ),
                  ],
                ),
                const Gap(4),
                Text(
                  '기록, 즐겨찾기, 업로드 관리',
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
