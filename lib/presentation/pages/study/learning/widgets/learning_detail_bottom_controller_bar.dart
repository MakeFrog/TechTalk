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
            height: 74,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderLabelIconButton(
                  isActive: currentIndex(ref) != 0,
                  label: tr(LocaleKeys.learning_previous),
                  icon: Assets.iconsArrowLeft,
                  onTap: () => onTapPrevQuestion(ref),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.of.background1,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${currentIndex(ref) + 1}',
                              style: AppTextStyle.title3.copyWith(
                                color: AppColor.of.gray6,
                              ),
                            ),
                            TextSpan(
                              text: '/${qnas(ref).length}',
                              style: AppTextStyle.body2.copyWith(
                                color: AppColor.of.gray6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // IconFlashAreaButton.assetIcon(
                    //   size: 24,
                    //   activatedColor: AppColor.of.gray4,
                    //   enabledColor: AppColor.of.gray2,
                    //   onIconTapped: () => onTapEntireQuestion(ref),
                    // ),
                    const Gap(6),
                    Text(
                      tr(LocaleKeys.learning_all),
                      style: AppTextStyle.body3.copyWith(
                        color: AppColor.of.gray4,
                      ),
                    ),
                  ],
                ),
                UnderLabelIconButton(
                  isActive: currentIndex(ref) + 1 != qnas(ref).length,
                  label: tr(LocaleKeys.learning_next),
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
