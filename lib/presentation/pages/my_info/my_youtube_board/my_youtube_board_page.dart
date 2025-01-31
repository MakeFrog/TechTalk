import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/constant/youtube_board_tab_type.enum.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/my_youtube_board_event.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/my_youtube_board_state.dart';
import 'package:techtalk/presentation/pages/youtube/main/widgets/youtube_pagination_indicator_view.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/indicator/tecktalk_refresh_indicator.dart';
import 'package:techtalk/presentation/widgets/common/item/youtube_content_small_item_view.dart';
import 'package:techtalk/presentation/widgets/common/tab_bar/techtalk_tab_bar.dart';

part 'widgets/bookmarked_tab_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/tab_bar.p.dart';
part 'widgets/uploaded_content_tab_view.p.dart';
part 'widgets/watched_history_tab_view.p.dart';

class MyYoutubeBoardPage extends BasePage
    with MyYoutubeBoardState, YoutubeMainState {
  const MyYoutubeBoardPage({
    super.key,
  });

  @override
  void onInit(WidgetRef ref) {
    super.onInit(ref);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      tabBar: _TabBar(),
      watchedHistoryTabView: _WatchHistoryTabView(),
      bookmarkedTabView: _BookmarkedTabView(),
      uploadedContentTabView: _UploadedContentTabView(),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar(
      title: '내 영상 학습',
    );
  }
}
