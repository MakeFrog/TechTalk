part of '../my_youtube_board_page.dart';

class _UploadedContentTabView extends HookConsumerWidget
    with MyYoutubeBoardState, MyYoutubeBoardEvent {
  const _UploadedContentTabView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    // 업로드 목록 페이징 컨트롤러 가져오기
    final pagingController = uploadedHistoryPagingControllerState(ref);

    return Stack(
      children: [
        PagedListView<DocumentSnapshot<UploadedYoutubeModel>?,
            YoutubeMainEntity>(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          pagingController: pagingController,
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
        ),

        /// 영상 업로드 플로팅 버튼
        if (showUploadFloatingButtonState(ref)) _buildUploadFloatingButton(ref),
      ],
    );
  }

  ///
  /// 업로드 바로가기 플로팅 버튼
  ///
  Positioned _buildUploadFloatingButton(WidgetRef ref) {
    return Positioned(
      right: 16,
      bottom: 36,
      child: GestureDetector(
        onTap: () => goToUploadPage(ref),
        child: CircleAvatar(
          radius: 28,
          foregroundColor: AppColor.of.white,
          backgroundColor: AppColor.of.blue2,
          child: SvgPicture.asset(
            Assets.iconsVideoUpload,
            colorFilter: ColorFilter.mode(
              AppColor.of.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// 호출 중 오류 발생
  ///
  Widget _buildErrorOccuredView(
    PagingController<DocumentSnapshot<UploadedYoutubeModel>?, YoutubeMainEntity>
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

  ///
  /// 업로드한 영상 없을 경우
  ///
  Widget _buildNoItemFoundView(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: YoutubePaginationIndicatorView(
        description: tr(LocaleKeys.youtubeBoard_noUploadsDescription),
        btnText: tr(LocaleKeys.youtubeBoard_noUploadsDescription),
        descriptionTextStyle: AppTextStyle.body2.copyWith(
          color: AppColor.of.black,
        ),
        onBtnTapped: () => goToUploadPage(ref),
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
