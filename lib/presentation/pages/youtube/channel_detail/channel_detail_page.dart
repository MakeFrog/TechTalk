import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/channel_detail_event.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/channel_detail_state.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/main/widgets/youtube_pagination_indicator_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/grid_view/expandable_youtube_content_grid_view.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';

part 'widgets/channel_info_view.p.dart';
part 'widgets/content_grid_view.p.dart';
part 'widgets/scaffold.p.dart';

class ChannelDetailPage extends BasePage {
  const ChannelDetailPage(this.arg, {super.key});

  final ChannelDetailRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      channelDetailRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      channelInfoView: _ChannelInfoView(),
      contentGridView: _ContentGridView(),
    );
  }

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
