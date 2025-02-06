part of '../youtube_detail_page.dart';

class _SummaryTabView extends HookConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _SummaryTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return ExtendedVisibilityDetector(
      uniqueKey: Key(ContentsDetailTabType.summary.displayStr),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(
              top: 24,
              bottom: 102,
            ),
        children: [
          _buildSummaryView(),

          const Gap(32),

          /// 관련 영상
          _buildRelatedVideosView(),
        ],
      ),
    );
  }

  /// 핵심주제
  Widget _buildSummaryView() {
    return Consumer(
      child: SectionTitle(
        title: tr(LocaleKeys.youtubeDetail_keyTopic),
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
                      SectionTitle(
                        title: tr(LocaleKeys.youtubeDetail_summaryNote),
                        iconPath: Assets.iconsSummaryNote,
                      ),
                      const Spacer(),
                      AllButton(
                        onTap: () {
                          triggerSeeAllNotifier.value =
                              triggerSeeAllNotifier.value + 1;
                        },
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
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: filteredSummaries.length,
                                            separatorBuilder: (_, __) =>
                                                const Gap(2),
                                            itemBuilder: (context, index) {
                                              return HookBuilder(
                                                builder:
                                                    (BuildContext context) {
                                                  final isExpanded =
                                                      useState(false);
                                                  final item =
                                                      filteredSummaries[index];

                                                  return SummaryNoteFoldableItem(
                                                    onTileBodyTapped:
                                                        (timestamp,
                                                            isExpanded) {
                                                      onSummaryListTileItemTapped(
                                                        ref,
                                                        timestamp: timestamp,
                                                        isExpanded: isExpanded,
                                                        selectedIndex:
                                                            selectedNoteIndex,
                                                        currentIndex: index,
                                                      );
                                                    },
                                                    onTapTimestamp: (timeStamp,
                                                        isExpanded) async {
                                                      await onTimeStampTapped(
                                                        ref,
                                                        timeStamp: timeStamp,
                                                      );

                                                      //// 항목 active 상태 toggle
                                                      if (selectedNoteIndex
                                                              .value !=
                                                          index) {
                                                        selectedNoteIndex
                                                            .value = index;
                                                      }
                                                    },
                                                    timestamp: item.timestamp,
                                                    title: item.title,
                                                    contents: item.contents,
                                                    isActivated:
                                                        selectedNoteIndex
                                                                .value ==
                                                            index,
                                                    seeAllNotifier:
                                                        triggerSeeAllNotifier,
                                                    isExpanded: isExpanded,
                                                  );
                                                },
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
      child: SectionTitle(
        title: tr(LocaleKeys.youtubeDetail_relatedVideos),
        iconPath: Assets.iconsSparkle,
      ),
      builder: (context, ref, title) {
        return Column(
          children: [
            if (relatedVideoAsync(ref).isLoading ||
                (relatedVideoAsync(ref).hasValue &&
                    (relatedVideoAsync(ref).value?.isNotEmpty ?? false))) ...[
              title!,
              const Gap(8),
            ],
            relatedVideoAsync(ref).whenFetchOrNull(
              data: (relatedVideos) {
                return ExpandableYoutubeContentGridView(
                  video: relatedVideos,
                  onTap: (video) {
                    onRelatedVideoTapped(ref, video: video);
                  },
                );
              },
              error: (_, __) => const EmptyBox(),
            ),
          ],
        );
      },
    );
  }
}

class ItemCardLayoutGrid extends StatelessWidget {
  const ItemCardLayoutGrid({
    Key? key,
    required this.crossAxisCount,
    required this.items,
  })
  // we only plan to use this with 1 or 2 columns
  : assert(crossAxisCount == 1 || crossAxisCount == 2),
        // assume we pass an list of 4 items for simplicity
        assert(items.length == 4),
        super(key: key);
  final int crossAxisCount;
  final List<VideoOverviewEntity> items;

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      // set some flexible track sizes based on the crossAxisCount
      columnSizes: crossAxisCount == 2 ? [1.fr, 1.fr] : [1.fr],
      // set all the row sizes to auto (self-sizing height)
      rowSizes: crossAxisCount == 2
          ? const [auto, auto]
          : const [auto, auto, auto, auto],
      rowGap: 40,
      // equivalent to mainAxisSpacing
      columnGap: 24,
      // equivalent to crossAxisSpacing
      // note: there's no childAspectRatio
      children: [
        // render all the cards with *automatic child placement*
        for (var i = 0; i < items.length; i++)
          ListTile(title: Text(items[i].title)),
      ],
    );
  }
}
