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
    required this.tabController,
  });

  final Override argOverride;
  final Widget appBar;
  final Widget youtubePlayerPlaceHolder;
  final Widget contentInfoView;
  final Widget tabBar;
  final Widget summaryTabView;
  final Widget interviewTabView;
  final Widget bottomFloatingView;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    /// 스크롤에 따른 FAB 노출 애니메이션 조정 값
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 370),
    );
    bool isFabHidden = false;
    double lastOffset = 0;

    final offsetAnimation = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0, 1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    useEffect(() {
      animationController.value = 1.0;
      tabController.addListener(() {
        /// '면접 질문'으로 탭 인덱스가 변경 되었을 때
        /// 항상 FAB를 노출하도록 설정
        if (tabController.index == 1 && animationController.isDismissed) {
          animationController.forward();
        }
      });
      return null;
    }, []);

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
                          // 가로 스크롤은 무시
                          if (notification.metrics.axisDirection ==
                                  AxisDirection.left ||
                              notification.metrics.axisDirection ==
                                  AxisDirection.right) {
                            return false;
                          }

                          if ((tabController.animation?.isAnimating ?? true) ||
                              tabController.index == 1) {
                            return false;
                          }

                          // 스크롤이 “시작”될 때 → 현재 픽셀 위치를 기준점으로 기록
                          if (notification is ScrollStartNotification) {
                            lastOffset = notification.metrics.pixels;
                          }
                          // 스크롤 “진행” 중 업데이트
                          else if (notification is ScrollUpdateNotification) {
                            final currentOffset = notification.metrics.pixels;
                            final diff =
                                currentOffset - lastOffset; // 기준점 대비 이동 거리
                            final delta = notification
                                .scrollDelta; // 이번 업데이트에서의 이동량(양수=아래, 음수=위)

                            // ─────────────
                            // 1) 아래로 50px 이상 드래그했을 때 → FAB 숨김
                            //    (단, 이미 숨겨져있지 않아야 하고, 현재 애니메이션 중이 아니어야 함)
                            // ─────────────
                            if (!isFabHidden &&
                                diff > 50 &&
                                !animationController.isAnimating &&
                                delta != null &&
                                delta > 0) {
                              animationController.reverse(); // FAB 사라짐
                              isFabHidden = true;
                              lastOffset = currentOffset; // 스크롤 기준점 갱신
                            }
                            // ─────────────
                            // 2) 위로 50px 이상 드래그했을 때 → FAB 다시 보임
                            //    (단, 이미 보이는 상태면 안 되고, 현재 애니메이션 중이 아니어야 함)
                            // ─────────────
                            else if (isFabHidden &&
                                diff < -50 &&
                                !animationController.isAnimating &&
                                delta != null &&
                                delta < 0) {
                              animationController.forward(); // FAB 나타남
                              isFabHidden = false;
                              lastOffset = currentOffset; // 스크롤 기준점 갱신
                            }

                            // ─────────────────────────────────────
                            // 3) “맨 아래(maxScrollExtent)”까지 간 경우 → FAB 항상 보이게
                            //    (isFabHidden 상태라면 보여주고, 기준점 갱신)
                            // ─────────────────────────────────────
                            if (notification.metrics.pixels >=
                                notification.metrics.maxScrollExtent) {
                              if (isFabHidden &&
                                  !animationController.isAnimating) {
                                animationController.forward(); // FAB 나타남
                                isFabHidden = false;
                                lastOffset = currentOffset;
                              }
                            }
                          }
                          return false;
                        },
                        child: ExtendedNestedScrollView(
                          pinnedHeaderSliverHeightBuilder: () {
                            return (AppSize.screenWidth * 9 / 16) +
                                AppSize.statusBarHeight -
                                AppSize.ratioHeight(14);
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
                              actions: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_horiz_outlined,
                                    color: AppColor.of.black,
                                  ),
                                ),
                              ],
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
                            controller: tabController,
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
          hasAtLeastOneOfQnaSelected(ref);

          return scaffold!;
        },
      ),
    );
  }
}
