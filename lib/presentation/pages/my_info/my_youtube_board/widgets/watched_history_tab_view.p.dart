part of '../my_youtube_board_page.dart';

class _WatchHistoryTabView extends ConsumerWidget
    with MyYoutubeBoardState, MyYoutubeBoardEvent {
  const _WatchHistoryTabView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = watchedHistoryPagingControllerState(ref);
    return TechtalkRefreshIndicator(
      onRefresh: () => refreshWatchedHistoryList(ref),
      child: PagedListView<DocumentSnapshot<WatchedYoutubeModel>?,
          YoutubeMainEntity>(
        pagingController: pagingController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
          itemBuilder: (context, item, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: BounceTapper(
                onTap: () => routeToDetailPage(ref, overview: item),
                child: YoutubeContentSmallItemView(
                  thumbnailImgUrl: item.thumbnailImgUrl,
                  title: item.contentsTitle,
                  channelName: item.channel.name,
                  videoDuration: item.videoDuration,
                  questionCount: item.qnaNum,
                  videoId: item.id,
                ),
              ),
            );
          },
          firstPageErrorIndicatorBuilder: (_) =>
              _buildErrorOccuredView(pagingController),
          newPageErrorIndicatorBuilder: (_) => const SizedBox(),
          newPageProgressIndicatorBuilder: (_) => const SizedBox(),
          noItemsFoundIndicatorBuilder: (context) =>
              _buildNoItemFoundView(context, ref),
        ),
      ),
    );
  }

  ///
  /// 호출 중 오류 발생
  ///
  Widget _buildErrorOccuredView(
    PagingController<DocumentSnapshot<WatchedYoutubeModel>?, YoutubeMainEntity>
        controller,
  ) {
    return YoutubePaginationIndicatorView(
      title: '데이터를 불러오지 못했어요',
      description: '일시적인 오류일 수 있으니 다시 시도해보세요',
      btnText: '다시 시도',
      onBtnTapped: () {
        controller.refresh();
      },
    );
  }

  Widget _buildNoItemFoundView(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: YoutubePaginationIndicatorView(
        description: '아직 시청 기록이 없어요',
        btnText: '영상 시청하기',
        descriptionTextStyle: AppTextStyle.body2.copyWith(
          color: AppColor.of.black,
        ),
        onBtnTapped: () => goToYoutubeMainPage(ref),
        buttonStyle: FilledButton.styleFrom(
          backgroundColor: AppColor.of.blue1,
          foregroundColor: AppColor.of.brand3,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
        ),
      ),
    );
  }
}
