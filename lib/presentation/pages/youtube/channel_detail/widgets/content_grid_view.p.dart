part of '../channel_detail_page.dart';

class _ContentGridView extends ConsumerWidget
    with ChannelDetailState, ChannelDetailEvent {
  const _ContentGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PagedListView<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeMainEntity>(
      shrinkWrap: true, // 스크롤 뷰 안에 맞춤
      physics: const NeverScrollableScrollPhysics(), // 내부 스크롤 비활성화
      pagingController: pagingController(ref),
      builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
        itemBuilder: (context, item, index) {
          // 데이터 리스트
          final itemList = pagingController(ref).itemList ?? [];

          // 현재 페이지에 있는 아이템의 개수 확인
          final firstIndex = index * 2;
          final secondIndex = firstIndex + 1;

          // 첫 번째 아이템
          final firstItem =
              firstIndex < itemList.length ? itemList[firstIndex] : null;

          // 두 번째 아이템
          final secondItem =
              secondIndex < itemList.length ? itemList[secondIndex] : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 첫 번째 아이템
                Expanded(
                  child: firstItem != null
                      ? _buildContent(ref, content: firstItem)
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 8), // 열 간 간격
                // 두 번째 아이템 (존재하지 않을 경우 빈 공간)
                Expanded(
                  child: secondItem != null
                      ? _buildContent(ref, content: secondItem)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (_) =>
            ExpandableYoutubeContentGridView.createSkeleton(
          showSubtitleSkeleton: false,
        ),
        newPageProgressIndicatorBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        noItemsFoundIndicatorBuilder: (context) =>
            _buildExceptionView(ref, '결과가 없습니다'),
        firstPageErrorIndicatorBuilder: (context) =>
            _buildExceptionView(ref, '영상을 불러오지 못했어요'),
      ),
    );
  }

  /// 호출실패
  Widget _buildExceptionView(WidgetRef ref, String label) {
    return Container(
      height: AppSize.screenHeight -
          AppSize.statusBarHeight -
          56 -
          76 -
          36 -
          AppSize.bottomInset,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: YoutubePaginationIndicatorView(
              setFlexRatio: false,
              title: '영상을 불러오지 못했어요',
              description: '일시적이 오류일 수 있으니 다시 시도해보세요',
              btnText: '다시 시도',
              onBtnTapped: () {
                pagingController(ref).refresh();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 각 아이템을 빌드하는 메서드
  Widget _buildContent(WidgetRef ref, {required YoutubeMainEntity content}) {
    return GestureDetector(
      onTap: () {
        onContentTapped(ref, content: content);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 썸네일
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 167.54 / 94, // 썸네일 비율
              child: Image.network(
                content.thumbnailImgUrl,
                fit: BoxFit.cover,
                cacheWidth:
                    ((AppSize.screenWidth - 40) / 2).cacheSize(ref.context),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * (94 / 167.54),
                    child: const SkeletonBox(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 콘텐츠 제목
          Text(
            content.contentsTitle,
            style: AppTextStyle.body1,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
