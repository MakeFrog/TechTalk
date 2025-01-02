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
            return PagedListView<DocumentSnapshot<YoutubeMainModel>?,
                YoutubeContentOverviewEntity>(
              pagingController: targetController,
              physics: const NeverScrollableScrollPhysics(),
              builderDelegate:
                  PagedChildBuilderDelegate<YoutubeContentOverviewEntity>(
                itemBuilder: (context, item, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: BounceTapper(
                      onTap: () {
                        routeToDetailPage(context, overview: item);
                      },
                      child: YoutubeContentItemView(
                        thumbnailImgUrl: item.thumbnailImgUrl,
                        title: item.contentsTitle,
                        channelName: item.channel.name,
                        videoDuration: item.videoDuration,
                        questionCount: item.qnaNum,
                        skills: item.relatedSkillIds.toList(),
                        jobGroups: item.relatedJobs.toList(),
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
            );
          }),
    );
  }

  ///
  /// 호출 중 오류 발생
  ///
  Widget _buildErrorOccuredView(
      PagingController<DocumentSnapshot<YoutubeMainModel>?,
              YoutubeContentOverviewEntity>
          controller) {
    return YoutubePaginationIndicatorView(
      title: '영상을 불러오지 못했어요',
      description: '일시적이 오류일 수 있으니 다시 시도해보세요',
      btnText: '다시 시도',
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
      title: '결과가 없습니다',
      description: '영상을 업로드해 보세요\n영상 요약 및 질문을 생성해 드립니다',
      btnText: '영상 업로드하기',
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
