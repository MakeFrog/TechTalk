part of '../my_youtube_board_page.dart';

class _WatchHistoryTabView extends HookConsumerWidget
    with MyYoutubeBoardState, MyYoutubeBoardEvent {
  const _WatchHistoryTabView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final pagingController = watchedHistoryPagingControllerState(ref);
    return PagedListView<DocumentSnapshot<WatchedYoutubeModel>?,
        YoutubeMainEntity>(
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
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
      title: tr(LocaleKeys.youtubeBoard_loadErrorTitle),
      description: tr(LocaleKeys.youtubeBoard_loadErrorDescription),
      btnText: tr(LocaleKeys.youtubeBoard_retryButton),
      onBtnTapped: () {
        controller.refresh();
      },
    );
  }

  Widget _buildNoItemFoundView(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: YoutubePaginationIndicatorView(
        description: tr(LocaleKeys.youtubeBoard_noItemFoundDescription),
        btnText: tr(LocaleKeys.youtubeBoard_watchVideoButton),
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
