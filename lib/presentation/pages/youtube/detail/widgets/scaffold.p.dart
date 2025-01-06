part of '../youtube_detail_page.dart';

class _Scaffold extends StatelessWidget with YoutubeDetailState {
  const _Scaffold({
    required this.argOverride,
    required this.appBar,
    required this.youtubePlayer,
    required this.contentInfoView,
    required this.tabBar,
    required this.summaryTabBarView,
    required this.interviewTabBarView,
    required this.bottomFloatingView,
  });

  final Override argOverride;
  final Widget appBar;
  final Widget youtubePlayer;
  final Widget contentInfoView;
  final Widget tabBar;
  final Widget summaryTabBarView;
  final Widget interviewTabBarView;
  final Widget bottomFloatingView;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        argOverride,
      ],
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
              return DefaultTabController(
                length: ContentsDetailTabType.values.length, // 탭의 개수
                child: Scaffold(
                  backgroundColor: AppColor.of.white,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Transform.translate(
                    offset: Offset(
                      0,
                      AppSize.responsiveBottomInset,
                    ),
                    child: bottomFloatingView,
                  ),
                  body: NestedScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController(ref),
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverPersistentHeader(
                        floating: true,
                        pinned: true,
                        delegate: StickyDelegateContainer(
                          minHeight: AppSize.statusBarHeight,
                          maxHeight: AppSize.statusBarHeight,
                          child: const ColoredBox(color: Colors.white),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: appBar,
                      ),

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
                                child: youtubePlayer,
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
                          minHeight: 48,
                          maxHeight: 48,
                        ),
                      ),
                    ],
                    body: TabBarView(
                      children: [
                        // 첫 번째 탭 내용
                        // 각 탭의 내용을 스크롤 가능한 위젯으로 감싸기
                        summaryTabBarView,
                        // 두 번째 탭 내용
                        interviewTabBarView,
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
