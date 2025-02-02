part of '../youtube_main_page.dart';

class _ContentListView extends HookConsumerWidget
    with YoutubeMainState, YoutubeMainEvent {
  const _ContentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController(ref),
          itemCount: totalCategories(ref).length,
          itemBuilder: (context, index) {
            final targetController = pagingController(ref);
            return KeepAliveView(
              child: PagedListView<DocumentSnapshot<YoutubeMainModel>?,
                  YoutubeMainEntity>(
                pagingController: targetController,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
                  itemBuilder: (context, item, index) {
                    return Container(
                      padding: EdgeInsets.only(top: index == 0 ? 60 : 0),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: BounceTapper(
                        onTap: () {
                          routeToDetailPage(ref, overview: item);
                        },
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
                  firstPageProgressIndicatorBuilder: (_) => _buildLoadView(),
                  newPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) =>
                      _buildErrorOccuredView(targetController),
                  newPageErrorIndicatorBuilder: (_) =>
                      _buildErrorOccuredView(targetController),
                  noItemsFoundIndicatorBuilder: _buildNoItemFoundView,
                ),
              ),
            );
          }),
    );
  }

  ///
  /// 호출 중 오류 발생
  ///
  Widget _buildErrorOccuredView(
      PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>
          controller) {
    return YoutubePaginationIndicatorView(
      title: tr(LocaleKeys.youtube_loadErrorTitle),
      description: tr(LocaleKeys.youtube_loadErrorDescription),
      btnText: tr(LocaleKeys.youtube_retryButton),
      onBtnTapped: () {
        controller.refresh();
      },
    );
  }

  ///
  /// 검색된 항목 없음
  ///
  Widget _buildNoItemFoundView(BuildContext context) {
    return YoutubePaginationIndicatorView(
      title: tr(LocaleKeys.youtube_noResults),
      description: tr(LocaleKeys.youtube_uploadPrompt),
      btnText: tr(LocaleKeys.youtube_uploadButton),
      onBtnTapped: () {
        onVideoUploadBtnTapped(context);
      },
    );
  }

  ///
  /// skeleton 로딩
  ///
  Widget _buildLoadView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(60),
        ...List.generate(
          6,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: YoutubeContentItemView.createSkeleton(),
          ),
        ),
      ],
    );
  }
}
