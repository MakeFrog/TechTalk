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

              return BookMarkButton(
                onTap: () {
                  onBookmarkBtnTapped(ref);
                },
                isBookMarked: isBooMarkTapped,
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
                        tr(LocaleKeys.youtubeDetail_startInterview),
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
