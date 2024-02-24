part of '../learning_detail_page.dart';

class _BottomControllerBar extends ConsumerWidget
    with LearningDetailState, LearningDetailEvent {
  const _BottomControllerBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return qnasAsync(ref).when(
        data: (_) {
          return Container(
            color: Colors.white,
            height: 70,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderLabelIconButton(
                  isActive: currentIndex(ref) != 0,
                  label: '이전 문항',
                  icon: Assets.iconsArrowLeft,
                  onTap: () => onTapPrevQuestion(ref),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconFlashAreaButton.assetIcon(
                      iconPath: Assets.iconsMenu,
                      size: 24,
                      activatedColor: AppColor.of.gray4,
                      enabledColor: AppColor.of.gray2,
                      onIconTapped: () => onTapEntireQuestion(ref),
                    ),
                    const Gap(12),
                    Text(
                      '전체 문항',
                      style: AppTextStyle.alert1.copyWith(
                        color: AppColor.of.gray4,
                      ),
                    ),
                  ],
                ),
                UnderLabelIconButton(
                  isActive: currentIndex(ref) + 1 != qnas(ref).length,
                  label: '다음 문항',
                  icon: Assets.iconsArrowRight,
                  onTap: () => onTapNextQuestion(ref),
                ),
              ],
            ),
          );
        },
        error: (e, __) => const EmptyBox(),
        loading: () => const EmptyBox());
  }
}
