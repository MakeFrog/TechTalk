import 'dart:async';

import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/constant/youtube_play_state.enum.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/constants/contents_detail_tab_type.enum.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/summary_note_foldable_item.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_detail_event.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_detail_state.dart';
import 'package:techtalk/presentation/widgets/common/box/async_skeleton_widget_builder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeDetailPage extends ConsumerStatefulWidget {
  const YoutubeDetailPage({super.key, required this.argument});

  final YoutubeDetailArg argument;

  @override
  ConsumerState createState() => _YoutubeDetailPageState();
}

class _YoutubeDetailPageState extends ConsumerState<YoutubeDetailPage>
    with YoutubeDetailEvent, YoutubeDetailState {
  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        // ignore: scoped_providers_should_specify_dependencies
        youtubeDetailRouteArgProvider.overrideWithValue(widget.argument)
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
              return KeepAliveView(
                child: DefaultTabController(
                  length: ContentsDetailTabType.values.length, // 탭의 개수
                  child: Scaffold(
                    backgroundColor: AppColor.of.white,
                    body: NestedScrollView(
                      controller: scrollController(ref),
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        /// SAFRE AREA 영역
                        SliverAppBar(
                          primary: false,
                          pinned: true,
                          expandedHeight: 56,
                          leadingWidth: double.infinity,
                          leading: Gap(
                            AppSize.statusBarHeight,
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: FoldableAppBar(
                            scrollController: scrollController(ref),
                            showBackButton: true,
                            animatedPosition: 2,
                            actions: [
                              Consumer(
                                builder: (context, ref, child) {
                                  return AsyncSkeletonWidgetBuilder(
                                    asyncValue: isBookMarkCheckedAsync(ref),
                                    dataBuilder: (context, isChecked) {
                                      return BounceTapper(
                                        highlightBorderRadius:
                                            BorderRadius.circular(52),
                                        onTap: () {
                                          onBookmarkBtnTapped(ref);
                                        },
                                        child: Container(
                                          height: 56,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: SvgPicture.asset(
                                            isChecked
                                                ? Assets.iconsLilinedBookmark
                                                : Assets.iconsOutlinedBookmark,
                                          ),
                                        ),
                                      );
                                    },
                                    skeletonBuilder: (_) => const EmptyBox(),
                                  );
                                },
                              ),
                            ],
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
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: player,
                                ),
                                Positioned.fill(
                                  child: YoutubeValueBuilder(
                                    controller: youtubeController(ref),
                                    builder: (context, value) {
                                      return HookBuilder(
                                        builder: (context) {
                                          final state = useState(
                                              YoutubePlaySate.unStarted);
                                          final timer =
                                              useState<Timer?>(null); // 타이머를 관리

                                          useEffect(() {
                                            // 상태가 변경될 때 실행되는 로직
                                            final changedState =
                                                YoutubePlaySate.fromCode(
                                                    value.playerState.code);

                                            if (state.value != changedState) {
                                              state.value = changedState;

                                              // unStarted 상태에서 cued로 변경되기 전에 타이머 설정
                                              if (changedState ==
                                                      YoutubePlaySate
                                                          .unStarted ||
                                                  changedState ==
                                                      YoutubePlaySate.unknown) {
                                                timer.value
                                                    ?.cancel(); // 기존 타이머 취소
                                                timer.value = Timer(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  if (state.value !=
                                                      YoutubePlaySate.cued) {
                                                    state.value = YoutubePlaySate
                                                        .errorOccured; // cued로 변하지 않으면 에러 상태로 변경
                                                    // 다른 상태가 되면 타이머 취소
                                                  }
                                                });
                                              }

                                              timer.value?.cancel();
                                            }

                                            return () => timer.value
                                                ?.cancel(); // 컴포넌트 dispose 시 타이머 취소
                                          }, [value.playerState]);

                                          // 상태에 따라 다른 위젯 반환
                                          if (state.value ==
                                                  YoutubePlaySate.unStarted ||
                                              state.value ==
                                                  YoutubePlaySate.unknown ||
                                              state.value ==
                                                  YoutubePlaySate.cued) {
                                            return AspectRatio(
                                              aspectRatio: 9 / 16,
                                              child: SizedBox(
                                                height: double.infinity,
                                                width: double.infinity,
                                                child: Stack(
                                                  children: [
                                                    Image.network(
                                                      widget.argument.overView!
                                                          .thumbnailImgUrl,
                                                      width: double.infinity,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                    const Positioned.fill(
                                                      child: ColoredBox(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.5),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Builder(
                                                        builder: (context) {
                                                          if (state.value ==
                                                              YoutubePlaySate
                                                                  .cued) {
                                                            return IconButton(
                                                              onPressed: () {},
                                                              icon: SvgPicture
                                                                  .asset(
                                                                Assets
                                                                    .iconsPlay,
                                                              ),
                                                            );
                                                          } else {
                                                            return const CircularProgressIndicator(
                                                              strokeWidth: 2.5,
                                                              color:
                                                                  Colors.white,
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else if (state.value ==
                                              YoutubePlaySate.errorOccured) {
                                            return Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              color: Colors.yellow,
                                              child: const Center(
                                                child: Text(
                                                  "예상하지 못한 오류가 발생했어요",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const IgnorePointer(
                                              child: EmptyBox(),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 콘텐츠 영역을 SliverToBoxAdapter로 감싸기
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Wrap(
                              runSpacing: 5,
                              children: [
                                Consumer(
                                  builder: (context, ref, _) {
                                    return AsyncSkeletonWidgetBuilder(
                                      asyncValue: mainInfo(ref),
                                      dataBuilder: (context, mainInfo) => Text(
                                        mainInfo.contentsTitle,
                                        style: AppTextStyle.headline3,
                                      ),
                                    );
                                  },
                                ),
                                AsyncSkeletonWidgetBuilder(
                                  asyncValue: mainInfo(ref),
                                  dataBuilder: (context, mainInfo) => Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:

                                            /// TODO : XIMYA
                                            /// 예외처리 모듈 만들기
                                            NetworkImage(
                                                mainInfo.channel.logoUrl ?? ''),
                                        radius: 15,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        mainInfo.channel.name,
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                                Consumer(
                                  builder: (context, ref, _) {
                                    return AsyncSkeletonWidgetBuilder(
                                        asyncValue: mainInfo(ref),
                                        dataBuilder: (context, mainInfo) {
                                          return Wrap(
                                            spacing: 8.0,
                                            children: [
                                              ...mainInfo.relatedSkillIds
                                                  .map(
                                                    (skill) => Chip(
                                                        label:
                                                            Text(skill.name)),
                                                  )
                                                  .toList(),
                                              ...mainInfo.relatedJobs
                                                  .map(
                                                    (job) => Chip(
                                                        label: Text(job.name)),
                                                  )
                                                  .toList(),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // TabBar를 SliverPersistentHeader로 감싸기
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.black), // 인디케이터 두께와 색상
                                insets: EdgeInsets.symmetric(
                                    horizontal: 70.0), // 인디케이터의 가로 여백 조정
                              ),
                              tabs: ContentsDetailTabType.values
                                  .map((tab) => Tab(
                                        text: tab.displayStr,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                      body: TabBarView(
                        children: [
                          // 첫 번째 탭 내용
                          // 각 탭의 내용을 스크롤 가능한 위젯으로 감싸기
                          Consumer(
                            builder: (context, ref, _) {
                              final targetAsync = summaryAsync(ref);

                              return ListView(
                                padding: const EdgeInsets.all(16),
                                children: [
                                  AsyncSkeletonWidgetBuilder(
                                    asyncValue: targetAsync,
                                    skeletonBuilder: (p0) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    dataBuilder: (context, data) => Wrap(
                                      runSpacing: 50,
                                      children: [
                                        if (data.mainTheme.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '핵심 주제',
                                              ),
                                              const SizedBox(height: 8),
                                              Text(data.mainTheme),
                                            ],
                                          ),
                                        if (data.summaries.isNotEmpty)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '요약 노트',
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Wrap(
                                                runSpacing: 10,
                                                children: [
                                                  ...data.summaries
                                                      .map(
                                                        (summary) =>
                                                            SummaryNoteFoldableItem(
                                                          timestamp:
                                                              summary.timestamp,
                                                          title: summary.title,
                                                          contents:
                                                              summary.contents,
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          // 두 번째 탭 내용
                          ListView(
                            padding: const EdgeInsets.all(16),
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  return AsyncSkeletonWidgetBuilder(
                                    asyncValue: qnasAsync(ref),
                                    skeletonBuilder: (p0) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    dataBuilder: (context, data) => Wrap(
                                      runSpacing: 20,
                                      children: [
                                        if (data.isNotEmpty)
                                          ...data
                                              .map(
                                                (qna) => Column(
                                                  children: [
                                                    Text(
                                                      qna.question,
                                                    ),
                                                    if (qna.answer != null)
                                                      Text(
                                                        qna.answer!,
                                                      ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
    );
  }
}

/// SliverPersistentHeaderDelegate 구현
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColor.of.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
