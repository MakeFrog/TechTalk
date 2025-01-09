part of '../youtube_detail_page.dart';

class _Scaffold extends StatelessWidget with YoutubeDetailState {
  const _Scaffold({
    required this.argOverride,
    required this.appBar,
    required this.youtubePlayerPlaceHolder,
    required this.contentInfoView,
    required this.tabBar,
    required this.summaryTabView,
    required this.interviewTabView,
    required this.bottomFloatingView,
  });

  final Override argOverride;
  final Widget appBar;
  final Widget youtubePlayerPlaceHolder;
  final Widget contentInfoView;
  final Widget tabBar;
  final Widget summaryTabView;
  final Widget interviewTabView;
  final Widget bottomFloatingView;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        argOverride,
      ],
      child: Consumer(
        child: Consumer(
          builder: (context, ref, _) {
            return YoutubePlayerScaffold(
              fullscreenOrientations: AppSize.originScreenWidth > 600
                  ? [
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]
                  : [
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ],
              controller: youtubeController(ref),
              autoFullScreen: false,
              builder: (context, player) {
                return Scaffold(
                  backgroundColor: AppColor.of.white,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  resizeToAvoidBottomInset: false,
                  floatingActionButton: Transform.translate(
                    offset: Offset(
                      0,
                      AppSize.responsiveBottomInset,
                    ),
                    child: bottomFloatingView,
                  ),
                  body: SafeArea(
                    child: DefaultTabController(
                      length: ContentsDetailTabType.values.length, // 탭의 개수
                      child: ExtendedNestedScrollView(
                        pinnedHeaderSliverHeightBuilder: () {
                          return AppSize.screenWidth * 9 / 16 +
                              AppSize.statusBarHeight;
                        },
                        // controller: scrollController(ref),
                        onlyOneScrollInBody: true,
                        physics: const NeverScrollableScrollPhysics(),
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            child: appBar,
                          ),
                          // SliverAppBar(
                          //   backgroundColor: Colors.white,
                          //   floating: true,
                          //   stretchTriggerOffset: 60,
                          //   elevation: 0.0,
                          //   collapsedHeight: 56,
                          //   automaticallyImplyLeading: false,
                          //   titleSpacing: 0,
                          //   title: SizedBox(
                          //     height: 56,
                          //     child: Row(
                          //       children: [
                          //         AppBackButton(
                          //           onBackBtnTapped: () {
                          //             context.pop();
                          //           },
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: StickyDelegateContainer(
                              minHeight: AppSize.screenWidth * 9 / 16,
                              maxHeight: AppSize.screenWidth * 9 / 16,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: player,
                                  ),
                                  Positioned.fill(
                                    child: youtubePlayerPlaceHolder,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 콘텐츠 영역을 SliverToBoxAdapter로 감싸기
                          SliverToBoxAdapter(
                            child: contentInfoView,
                          ),
                          // TabBar를 SliverPersistentHeader로 감싸기
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: StickyDelegateContainer(
                              child: tabBar,
                              minHeight: YoutubeDetailPage.tabBarHeight,
                              maxHeight: YoutubeDetailPage.tabBarHeight,
                            ),
                          ),
                        ],
                        body: TabBarView(
                          // physics: const PageScrollPhysics(), // 기본 가로 스크롤 허용
                          children: [
                            // 첫 번째 탭 내용
                            // 각 탭의 내용을 스크롤 가능한 위젯으로 감싸기
                            summaryTabView,
                            // 두 번째 탭 내용
                            interviewTabView,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        builder: (context, ref, scaffold) {
          mainInfo(ref);
          summaryAsync(ref);
          qnasAsync(ref);
          isBookMarkCheckedAsync(ref);
          relatedVideoAsync(ref);

          return scaffold!;
        },
      ),
    );
  }
}
