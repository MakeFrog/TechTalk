part of '../blog_main_page.dart';

class _ContentListView extends ConsumerWidget
    with BlogMainState, BlogMainEvent {
  const _ContentListView();

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
              child: PagedListView<DocumentSnapshot<BlogMainModel>?,
                  BlogShellEntity>(
                pagingController: targetController,
                physics: const BouncingScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate<BlogShellEntity>(
                  itemBuilder: (context, item, index) {
                    return Container(
                      padding: EdgeInsets.only(top: index == 0 ? 60 : 0),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: BounceTapper(
                        onTap: () {
                          // routeToDetailPage(ref, overview: item);
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Text(item.title),
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
      PagingController<DocumentSnapshot<BlogMainModel>?, BlogShellEntity>
          controller) {
    print('Blog Content Error Occurred'); // 디버그 로그
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
      title: 'tr(LocaleKeys.youtube_noItemFoundTitle)',
      description: 'tr(LocaleKeys.youtube_noItemFoundDescription)',
      btnText: '',
      onBtnTapped: () {},
    );
  }

  ///
  /// 로딩 뷰
  ///
  Widget _buildLoadView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void onVideoUploadBtnTapped(BuildContext context) {}
}
