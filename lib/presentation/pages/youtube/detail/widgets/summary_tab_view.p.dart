part of '../youtube_detail_page.dart';

class _SummaryTabView extends HookConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _SummaryTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16) +
          const EdgeInsets.only(
            top: 24,
            bottom: 212,
          ),
      children: [
        _buildSummaryView(),

        const Gap(32),

        /// 관련 영상
        _buildRelatedVideosView(),
      ],
    );
  }

  /// 핵심주제
  Widget _buildSummaryView() {
    return Consumer(
      child: _buildTitle(
        title: '핵심 주제',
        iconPath: Assets.iconsCoreCircle,
      ),
      builder: (context, ref, title) {
        return Column(
          children: [
            if (summaryAsync(ref).isLoading ||
                (summaryAsync(ref).hasValue &&
                    (summaryAsync(ref).value?.mainTheme.isNotEmpty ?? false)))
              title!,
            AsyncSkeletonWidgetBuilder(
              asyncValue: summaryAsync(ref),
              skeletonBuilder: (_) => const Column(
                children: [
                  SizedBox(height: 8),
                  FilledTextBox(
                    contents: ['\n\n\n\n\n'],
                  ),
                ],
              ),
              dataBuilder: (context, info) => Wrap(
                runSpacing: 32,
                children: [
                  if (info.mainTheme.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        FilledTextBox(
                          contents: [
                            info.mainTheme,
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),

            /// 요약노트
            HookBuilder(
              builder: (context) {
                final triggerSeeAllNotifier = useState(0);
                return Consumer(
                  child: Row(
                    children: [
                      _buildTitle(
                        title: '요약 노트',
                        iconPath: Assets.iconsSummaryNote,
                      ),
                      const Spacer(),
                      BounceTapper(
                        onTap: () {
                          triggerSeeAllNotifier.value =
                              triggerSeeAllNotifier.value + 1;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColor.of.gray2,
                            ),
                          ),
                          child: Text(
                            '전체보기',
                            style: AppTextStyle.alert1.copyWith(
                              color: AppColor.of.gray5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  builder: (context, ref, title) {
                    return Column(
                      children: [
                        if (summaryAsync(ref).isLoading ||
                            (summaryAsync(ref).hasValue &&
                                (summaryAsync(ref)
                                        .value
                                        ?.summaries
                                        .isNotEmpty ??
                                    false))) ...[
                          const Gap(32),
                          title!,
                          const Gap(8),
                        ],
                        AsyncSkeletonWidgetBuilder(
                          asyncValue: summaryAsync(ref),
                          skeletonBuilder: (_) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return SummaryNoteFoldableItem.loading();
                              },
                            );
                          },
                          dataBuilder: (context, info) => Wrap(
                            children: [
                              if (info.summaries.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HookBuilder(
                                      builder: (context) {
                                        final filteredSummaries = useMemoized(
                                            () => info.summaries
                                              ..removeWhere((e) =>
                                                  e.title.isEmpty ||
                                                  e.contents.isEmpty));

                                        final selectedNoteIndex =
                                            useState<int?>(null);
                                        return KeepAliveView(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: filteredSummaries.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  filteredSummaries[index];
                                              return SummaryNoteFoldableItem(
                                                onTapTimestamp:
                                                    (timeStamp) async {
                                                  await onTimeStampTapped(
                                                    ref,
                                                    timeStamp: timeStamp,
                                                  );

                                                  //// 항목 active 상태 toggle
                                                  if (selectedNoteIndex.value !=
                                                      index) {
                                                    selectedNoteIndex.value =
                                                        index;
                                                  }
                                                },
                                                timestamp: item.timestamp,
                                                title: item.title,
                                                contents: item.contents,
                                                isActivated:
                                                    selectedNoteIndex.value ==
                                                        index,
                                                seeAllNotifier:
                                                    triggerSeeAllNotifier,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  /// 관련 영상
  Widget _buildRelatedVideosView() {
    return Consumer(
      child: _buildTitle(title: '관련 영상', iconPath: Assets.iconsSparkle),
      builder: (context, ref, title) {
        const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
          childAspectRatio: 167.54 / 138,
        );

        return Column(
          children: [
            if (relatedVideoAsync(ref).isLoading ||
                (relatedVideoAsync(ref).hasValue &&
                    (relatedVideoAsync(ref).value?.isNotEmpty ?? false))) ...[
              title!,
              const Gap(8),
            ],
            AsyncSkeletonWidgetBuilder(
              asyncValue: relatedVideoAsync(ref),
              skeletonBuilder: (_) =>
                  _buildRelatedGridViewSkeleton(gridDelegate),
              dataBuilder: (context, relatedVideos) {
                return KeepAliveView(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: gridDelegate,
                    itemCount: relatedVideos.length,
                    itemBuilder: (context, index) {
                      final video = relatedVideos[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AspectRatio(
                              aspectRatio: 167.54 / 94,
                              child: Image.network(
                                video.thumbnailImgUrl,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const MaxGap(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              video.title,
                              style: AppTextStyle.body1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              video.channelName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppTextStyle.alert2.copyWith(
                                color: AppColor.of.gray3,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  /// 제목 섹션
  Widget _buildTitle({
    required String title,
    required String iconPath,
  }) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        const Gap(2),
        Text(
          title,
          style: AppTextStyle.headline2,
        ),
      ],
    );
  }

  /// 그리드뷰 스켈레톤
  Widget _buildRelatedGridViewSkeleton(
      SliverGridDelegateWithFixedCrossAxisCount gridDelegate) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: gridDelegate,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const AspectRatio(
                aspectRatio: 167.54 / 94,
                child: SkeletonBox(),
              ),
            ),
            const MaxGap(8),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: SkeletonBox(
                padding: const EdgeInsets.symmetric(vertical: 2),
                width: AppSize.ratioWidth(110),
                height: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: SkeletonBox(
                width: AppSize.ratioWidth(40),
                padding: const EdgeInsets.symmetric(vertical: 2),
                height: 13,
              ),
            ),
          ],
        );
      },
    );
  }
}
