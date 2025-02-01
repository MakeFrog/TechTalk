part of '../youtube_detail_page.dart';

class _BottomFloatingView extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _BottomFloatingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 72 + AppSize.responsiveBottomInset,
      padding: EdgeInsets.fromLTRB(16, 16, 16, AppSize.responsiveBottomInset),
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          Consumer(
            builder: (context, ref, _) {
              final isBooMarkTapped =
                  isBookMarkCheckedAsync(ref).valueOrNull ?? false;

              return BounceTapper(
                onTap: () {
                  onBookmarkBtnTapped(ref);
                },
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColor.of.blue1,
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.iconsBoomark,
                      colorFilter: ColorFilter.mode(
                        isBooMarkTapped
                            ? AppColor.of.brand3
                            : AppColor.of.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const Gap(10),
          Expanded(
            child: Consumer(
              builder: (context, _, __) {
                return BounceTapper(
                  enable: hasAtLeastOneOfQnaSelected(ref),
                  onTap: hasAtLeastOneOfQnaSelected(ref)
                      ? () {
                          onStartInterviewBtnTapped(ref);
                        }
                      : null,
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: hasAtLeastOneOfQnaSelected(ref) ? () {} : null,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 18,
                        ),
                      ),
                      child: Text(
                        '면접 시작하기',
                        style: AppTextStyle.title1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
