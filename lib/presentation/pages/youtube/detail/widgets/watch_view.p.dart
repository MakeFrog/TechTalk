part of '../youtube_detail_page.dart';

class _WatchView extends ConsumerWidget with YoutubeDetailState {
  const _WatchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mainInfo(ref);
    summaryAsync(ref);
    qnasAsync(ref);
    isBookMarkCheckedAsync(ref);
    scrollController(ref);
    youtubeController(ref);
    relatedVideoAsync(ref);
    return const EmptyBox();
  }
}
