import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_event.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/chip/selectable_chip.dart';

part 'widgets/category_slider_bar.p.dart';

part 'widgets/content_list_view.p.dart';

part 'widgets/scaffold.p.dart';

class YoutubeMainPage extends BasePage with YoutubeMainState, YoutubeMainEvent {
  const YoutubeMainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

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
        actions: [
          IconButton(
            onPressed: () {
              onVideoUploadBtnTapped(context);
            },
            icon: SvgPicture.asset(
              Assets.iconsVideoUpload,
            ),
          ),
        ],
      );
}
