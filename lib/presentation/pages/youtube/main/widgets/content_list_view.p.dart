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
                firstPageProgressIndicatorBuilder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      6,
                      (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: YoutubeContentItemView.createSkeleton()),
                    ),
                  ],
                ),
                newPageProgressIndicatorBuilder: (context) =>
                    Center(child: CircularProgressIndicator()),
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('데이터 로딩 중 오류가 발생했습니다.'),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => targetController.refresh(),
                        child: Text('다시 시도'),
                      ),
                    ],
                  ),
                ),
                newPageErrorIndicatorBuilder: (context) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('추가 데이터 로딩 중 오류가 발생했습니다.'),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () =>
                            targetController.retryLastFailedRequest(),
                        child: Text('다시 시도'),
                      ),
                    ],
                  ),
                ),
                noItemsFoundIndicatorBuilder: (context) =>
                    Center(child: Text('데이터가 없습니다.')),
              ),
            );
          }),
    );
  }
}
