part of '../youtube_detail_page.dart';

class _Scaffold extends HookWidget with YoutubeDetailState {
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
    // 1) AnimationController 정의
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 370),
    );

    // 2) 초기 상태: FAB이 나타난 상태로 설정
    useEffect(() {
      animationController.value = 1.0;
      return null;
    }, []);

    // 3) 슬라이드 애니메이션 정의
    final offsetAnimation = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, 1.0), // 아래로 숨김
        end: Offset.zero, // 표시 상태
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return ProviderScope(
      overrides: [argOverride],
      child: Consumer(
        child: Consumer(
          builder: (context, ref, _) {
            return YoutubePlayerScaffold(
              enableFullScreenOnVerticalDrag: false,
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

                  // SlideTransition으로 FAB 애니메이션 적용
                  floatingActionButton: SlideTransition(
                    position: offsetAnimation,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        AppSize.responsiveBottomInset,
                      ),
                      child: bottomFloatingView,
                    ),
                  ),
                  body: SafeArea(
                    bottom: false,
                    child: DefaultTabController(
                      length: ContentsDetailTabType.values.length,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          // 1) ScrollNotification 체크
                          if (notification is UserScrollNotification) {
                            final direction = notification.direction;

                            // 2) 현재 스크롤 위치
                            final scrollOffset = notification.metrics.pixels;

                            // 3) 스크롤 위치가 20 이상일 때만 애니메이션 수행
                            if (scrollOffset > 100) {
                              // 스크롤을 내릴 때 (reverse)
                              if (direction == ScrollDirection.reverse &&
                                  animationController.status !=
                                      AnimationStatus.dismissed) {
                                animationController.reverse();
                                return false;
                              }

                              // 스크롤을 올릴 때 (forward)
                              if (direction == ScrollDirection.forward &&
                                  animationController.status !=
                                      AnimationStatus.completed) {
                                animationController.forward();
                                return false;
                              }
                            }
                          }
                          return false;
                        },
                        child: ExtendedNestedScrollView(
                          pinnedHeaderSliverHeightBuilder: () {
                            return AppSize.screenWidth * 9 / 16 +
                                AppSize.statusBarHeight;
                          },
                          onlyOneScrollInBody: true,
                          physics: const NeverScrollableScrollPhysics(),
                          headerSliverBuilder: (context, innerBoxIsScrolled) =>
                              [
                            SliverAppBar(
                              floating: true,
                              stretchTriggerOffset: 20,
                              elevation: 0.0,
                              collapsedHeight: 56,
                              automaticallyImplyLeading: false,
                              titleSpacing: 0,
                              title: AppBackButton(
                                onBackBtnTapped: () {
                                  context.pop();
                                },
                              ),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: StickyDelegateContainer(
                                minHeight: AppSize.screenWidth * 9 / 16,
                                maxHeight: AppSize.screenWidth * 9 / 16,
                                child: Stack(
                                  children: [
                                    SizedBox(
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
                            SliverToBoxAdapter(
                              child: contentInfoView,
                            ),
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
                            children: [
                              summaryTabView,
                              interviewTabView,
                            ],
                          ),
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
          /// [NOTE]
          /// YoutubePlayer가 fullScreen이 되면
          /// 위젯트리가 다시 생성되는 이슈가 있음.
          /// 이를 방지하기 위해 미리 provider를 초기화함.
          /// 이렇게 설정해도 성능상 이슈가 없다고 봐도 무방
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
