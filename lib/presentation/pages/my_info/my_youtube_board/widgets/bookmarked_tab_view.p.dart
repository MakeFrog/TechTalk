part of '../my_youtube_board_page.dart';

class _BookmarkedTabView extends HookConsumerWidget
    with MyYoutubeBoardState, MyYoutubeBoardEvent {
  const _BookmarkedTabView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final pagingController = bookmarkedPagingControllerState(ref);
    return PagedListView<DocumentSnapshot<BookmarkedYoutubeModel>?,
        YoutubeMainEntity>(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
        itemBuilder: (context, item, index) {
          return AnimatedSizeAndFade(
            child: _BookmarkAnimatedDeletableListItem(
              item: item,
              onConfirmDelete: () => deleteBookmark(ref, videoId: item.id),
              onTap: () {
                routeToDetailPage(ref, overview: item);
              },
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
    PagingController<DocumentSnapshot<BookmarkedYoutubeModel>?,
            YoutubeMainEntity>
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
        description: tr(LocaleKeys.youtubeBoard_noFavoritesDescription),
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
