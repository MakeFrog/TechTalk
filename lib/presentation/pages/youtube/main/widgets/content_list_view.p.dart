part of '../youtube_main_page.dart';

class _ContentListView extends HookConsumerWidget
    with YoutubeMainState, YoutubeMainEvent {
  const _ContentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
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
              itemBuilder: (context, item, index) => ListTile(
                leading: Image.network(
                  item.thumbnailImgUrl,
                  width: 100,
                  height: 56,
                  fit: BoxFit.cover,
                ),
                title: Wrap(
                  children: [
                    Text(item.contentsTitle),
                    ...item.relatedSkillIds.map((e) => Text(e.name)),
                    Text('질문 개수 : ${item.qnaNum}'),
                  ],
                ),
                subtitle: Text('Author: ${item.channel.name}'),
                trailing: Text(
                  '${item.videoDuration.inMinutes}m ${item.videoDuration.inSeconds % 60}s',
                ),
                onTap: () {
                  routeToDetailPage(context, overview: item);
                },
              ),
              firstPageProgressIndicatorBuilder: (context) =>
                  Center(child: CircularProgressIndicator()),
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
        });
  }
}
