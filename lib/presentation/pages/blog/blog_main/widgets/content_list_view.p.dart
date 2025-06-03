part of '../blog_main_page.dart';

class _ContentListView extends ConsumerWidget
    with BlogMainState, BlogMainEvent {
  const _ContentListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController(ref),
        itemCount: totalCategories(ref).length,
        itemBuilder: (context, index) {
          final targetController = pagingController(ref);

          return LayoutBuilder(
            builder: (context, constraints) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: PagedSliverList<DocumentSnapshot<BlogMainModel>?,
                        BlogShellEntity>(
                      pagingController: targetController,
                      builderDelegate:
                          PagedChildBuilderDelegate<BlogShellEntity>(
                        itemBuilder: (context, item, index) {
                          return KeepAliveView(
                            child: BlogContentItemView(
                              key: ValueKey(item.id),
                              item: item,
                              onTap: () async {
                                await onBlogContentTapped(context, item);
                              },
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) =>
                            const SizedBox(
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        newPageProgressIndicatorBuilder: (_) => const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (_) =>
                            _buildErrorOccuredView(targetController),
                        newPageErrorIndicatorBuilder: (_) =>
                            _buildErrorOccuredView(targetController),
                        noItemsFoundIndicatorBuilder: _buildNoItemFoundView,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  ///
  /// 호출 중 오류 발생
  ///
  Widget _buildErrorOccuredView(
      PagingController<DocumentSnapshot<BlogMainModel>?, BlogShellEntity>
          controller) {
    return SizedBox(
      height: 200,
      child: YoutubePaginationIndicatorView(
        title: tr(LocaleKeys.youtube_loadErrorTitle),
        description: tr(LocaleKeys.youtube_loadErrorDescription),
        btnText: tr(LocaleKeys.youtube_retryButton),
        onBtnTapped: () {
          controller.refresh();
        },
      ),
    );
  }

  ///
  /// 검색된 항목 없음
  ///
  Widget _buildNoItemFoundView(BuildContext context) {
    return SizedBox(
      height: 200,
      child: YoutubePaginationIndicatorView(
        title: '검색된 내용이 없습니다',
        description: '다시 시도해 주세요',
        btnText: '',
        onBtnTapped: () {},
      ),
    );
  }

  void onVideoUploadBtnTapped(BuildContext context) {}
}
