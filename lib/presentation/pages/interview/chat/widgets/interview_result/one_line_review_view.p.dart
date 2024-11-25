part of 'interview_result_dialog.dart';

class _OnLineView extends HookConsumerWidget with ChatState, ChatEvent {
  const _OnLineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        28,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: AppColor.of.white,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          Text(
            tr(LocaleKeys.interview_oneLineFeedback),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.headline1,
          ),
          const Spacer(),
          SvgPicture.asset(
            Assets.iconsPonderingIllusration,
          ),
          Container(
              height: 108,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.of.background1,
              ),
              child: HookConsumer(
                builder: (context, ref, _) {
                  final scrollController = useScrollController();

                  // 스크롤 하단 이동 로직 (오버플로우 시에만)
                  void scrollToBottomIfOverflowed() {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        final maxScrollExtent =
                            scrollController.position.maxScrollExtent;
                        final currentScrollOffset = scrollController.offset;

                        // 현재 스크롤 위치와 최대 스크롤 범위 비교
                        if (currentScrollOffset < maxScrollExtent) {
                          scrollController.jumpTo(maxScrollExtent);
                        }
                      }
                    });
                  }

                  return SingleChildScrollView(
                    controller: scrollController,
                    child: StreamBuilder<String>(
                      stream: oneLineStreamFeedback(ref),
                      builder: (context, snapshot) {
                        // 데이터가 업데이트될 때만 실행
                        if (snapshot.hasData) {
                          scrollToBottomIfOverflowed();
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            tr(LocaleKeys.interview_generatingOneLineFeedback),
                            style: TextStyle(
                              color: AppColor.of.gray4,
                              fontFamily: 'pretendard',
                              leadingDistribution: TextLeadingDistribution.even,
                              letterSpacing: -2 / 100 * 13,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 20 / 13,
                            ),
                          )
                              .animate(
                                  delay: 320.ms,
                                  onPlay: (controller) => controller.repeat(
                                      period: 500.milliseconds))
                              .shimmer(color: Colors.white.withOpacity(0.5));
                        }

                        if (snapshot.hasError) {
                          return Text(
                            tr(LocaleKeys.common_errorDetectedTryLater),
                            style: const TextStyle(
                              fontFamily: 'pretendard',
                              leadingDistribution: TextLeadingDistribution.even,
                              letterSpacing: -2 / 100 * 13,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              height: 20 / 13,
                            ),
                          );
                        }

                        return Text(
                          snapshot.data ?? '',
                          style: const TextStyle(
                            fontFamily: 'pretendard',
                            leadingDistribution: TextLeadingDistribution.even,
                            letterSpacing: -2 / 100 * 13,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 20 / 13,
                          ),
                        );
                      },
                    ),
                  );
                },
              )),
          const Gap(
            16,
          ),
          SizedBox(
            height: 48,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: FilledButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: AppColor.of.gray3,
                        backgroundColor: AppColor.of.gray1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                      child: Text(
                        tr(LocaleKeys.common_cancel),
                        style: AppTextStyle.title1,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: () {
                      changePageViewIndex(ref, index: 2);
                    },
                    child: Text(
                      tr(LocaleKeys.common_next),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
