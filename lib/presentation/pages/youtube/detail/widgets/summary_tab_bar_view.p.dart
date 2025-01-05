part of '../youtube_detail_page.dart';

class _SummaryTabBarView extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _SummaryTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AsyncSkeletonWidgetBuilder(
          asyncValue: summaryAsync(ref),
          skeletonBuilder: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          dataBuilder: (context, data) => Wrap(
            runSpacing: 50,
            children: [
              if (data.mainTheme.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '핵심 주제',
                    ),
                    const SizedBox(height: 8),
                    Text(data.mainTheme),
                  ],
                ),
              if (data.summaries.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '요약 노트',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        ...data.summaries
                            .map(
                              (summary) => SummaryNoteFoldableItem(
                                timestamp: summary.timestamp,
                                title: summary.title,
                                contents: summary.contents,
                              ),
                            )
                            .toList(),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
