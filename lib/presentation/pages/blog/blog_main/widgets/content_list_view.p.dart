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

          return KeepAliveView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PagedListView<DocumentSnapshot<BlogMainModel>?,
                        BlogShellEntity>(
                      pagingController: targetController,
                      physics: const BouncingScrollPhysics(),
                      builderDelegate:
                          PagedChildBuilderDelegate<BlogShellEntity>(
                        itemBuilder: (context, item, index) {
                          return Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            margin: EdgeInsets.only(
                              top: index == 0 ? 60 : 0,
                              bottom: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: BounceTapper(
                              onTap: () {
                                // routeToDetailPage(ref, overview: item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) => const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        newPageProgressIndicatorBuilder: (_) => const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
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
                );
              },
            ),
          );
        });
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

  void onVideoUploadBtnTapped(BuildContext context) {}
}
