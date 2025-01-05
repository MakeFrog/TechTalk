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

part 'widgets/appBar.p.dart';
part 'widgets/bottom_floating_View.p.dart';
part 'widgets/content_info_view.p.dart';
part 'widgets/interview_tab_bar_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/summary_tab_bar_view.p.dart';
part 'widgets/tab_bar.p.dart';
part 'widgets/youtube_player_place_holder.p.dart';

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
    return _Scaffold(
      argOverride:
          youtubeDetailRouteArgProvider.overrideWithValue(widget.argument),
      appBar: const _AppBar(),
      youtubePlayer: const _YoutubePlayerPlaceHolder(),
      contentInfoView: const _ContentInfoView(),
      tabBar: _buildTabBar(),
      bottomFloatingView: const _BottomFloatingView(),
      summaryTabBarView: const _SummaryTabBarView(),
      interviewTabBarView: const _InterviewTabBarView(),
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
