part of '../my_youtube_board_page.dart';

class _WatchHistoryTabView extends ConsumerWidget
    with MyYoutubeBoardState, YoutubeMainState {
  const _WatchHistoryTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PagedListView<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeContentOverviewEntity>(
      pagingController: pagingController(ref),
      builderDelegate: PagedChildBuilderDelegate<YoutubeContentOverviewEntity>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: BounceTapper(
              onTap: () {},
              child: YoutubeContentItemView(
                thumbnailImgUrl: item.thumbnailImgUrl,
                title: item.contentsTitle,
                channelName: item.channel.name,
                videoDuration: item.videoDuration,
                questionCount: item.qnaNum,
                skills: item.relatedSkillIds.toList(),
                jobGroups: item.relatedJobs.toList(),
                videoId: item.id,
              ),
            ),
          );
        },
        // firstPageProgressIndicatorBuilder: (_) => _buildLoadView(),
        // newPageProgressIndicatorBuilder: (_) =>
        // const Center(child: CircularProgressIndicator()),
        // firstPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // newPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // noItemsFoundIndicatorBuilder: _buildNoItemFoundView,
      ),
    );
  }
}
