import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/constant/youtube_board_tab_type.enum.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/tab_bar/techtalk_tab_bar.dart';

part 'widgets/bookmarked_tab_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/tab_bar.p.dart';
part 'widgets/uploaded_content_tab_view.p.dart';
part 'widgets/watched_history_tab_view.p.dart';

class MyYoutubeBoardPage extends BasePage {
  const MyYoutubeBoardPage({
    super.key,
  });

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
