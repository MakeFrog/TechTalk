part of '../youtube_detail_page.dart';

class _AppBar extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FoldableAppBar(
      scrollController: scrollController(ref),
      showBackButton: true,
      animatedPosition: 2,
    );
  }
}
