import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_content_main_event.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_content_main_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/chip/selectable_chip.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'widgets/scaffold.p.dart';

part 'widgets/category_slider_bar.p.dart';

part 'widgets/content_list_view.p.dart';

class YoutubeContentMainPage extends BasePage
    with YoutubeContentMainState, YoutubeContentMainEvent {
  const YoutubeContentMainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      categorySliderBar: _CategorySliderBar(),
      contentListView: _ContentListView(),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(
        title: const Text(
          '영상 학습',
        ),
      );
}
