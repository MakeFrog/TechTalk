import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/constants/contents_detail_tab_type.enum.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/summary_note_foldable_item.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_contents_detail_event.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_contents_detail_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/box/async_skeleton_widget_builder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

/// 유튜브 컨텐츠 상세 페이지
class YoutubeContentsDetailPage extends BasePage
    with YoutubeContentsDetailEvent, YoutubeContentsDetailState {
  const YoutubeContentsDetailPage({super.key, required this.argument});

  final YoutubeDetailArg argument;

  @override
  Override? get argProviderOverrides =>
      youtubeDetailRouteArgProvider.overrideWithValue(argument);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return DefaultTabController(
      length: ContentsDetailTabType.values.length, // 탭의 개수
      child: Scaffold(
        backgroundColor: AppColor.of.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // AppBar 대체
            SliverAppBar(
              leading: const AppBackButton(),
              titleSpacing: 0,
              backgroundColor: AppColor.of.white,
              pinned: true,
              expandedHeight: 210.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Consumer(
                  builder: (context, ref, _) {
                    return AsyncSkeletonWidgetBuilder(
                      asyncValue: mainInfo(ref),
                      dataBuilder: (context, mainInfo) {
                        return SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            mainInfo.thumbnailImgUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // 콘텐츠 영역을 SliverToBoxAdapter로 감싸기
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      asyncValue:
                          youtubeVideoDataAsync(ref, argument.contentId),
                      skeletonBuilder: (_) => const SkeletonBox(
                        height: 20,
                      ),
                      dataBuilder: (context, data) => Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_up,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(data.likeCountStr),
                            ],
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Text('조회수 ${data.viewCountStr}'),
                        ],
                      ),
                    ),
                    AsyncSkeletonWidgetBuilder(
                      asyncValue: mainInfo(ref),
                      dataBuilder: (context, mainInfo) => Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:

                                /// TODO : XIMYA
                                /// 예외처리 모듈 만들기
                                NetworkImage(mainInfo.channel.logoUrl ?? ''),
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
                                        (skill) =>
                                            Chip(label: Text(skill.name)),
                                      )
                                      .toList(),
                                  ...mainInfo.relatedJobs
                                      .map(
                                        (job) => Chip(label: Text(job.name)),
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
                        width: 2.0, color: Colors.black), // 인디케이터 두께와 색상
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              timestamp: summary.timestamp,
                                              title: summary.title,
                                              contents: summary.contents,
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
                  AsyncSkeletonWidgetBuilder(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get canPop => false;

  @override
  Color? get screenBackgroundColor => AppColor.of.white;

  @override
  Color? get unSafeAreaColor => AppColor.of.white;
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
