import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

import 'package:techtalk/presentation/pages/blog/blog_main/blog_main_event.dart';
import 'package:techtalk/presentation/pages/blog/blog_main/blog_main_state.dart';

import 'package:techtalk/presentation/pages/youtube/main/widgets/youtube_pagination_indicator_view.dart';

import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/techtalk_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/chip/selectable_category_chip.dart';
import 'package:techtalk/presentation/widgets/common/item/blog_content_item_view.dart';

import 'package:techtalk/presentation/widgets/common/state/keep_alive_view.dart';

part 'widgets/category_slider_bar.p.dart';
part 'widgets/content_list_view.p.dart';
part 'widgets/scaffold.p.dart';

class BlogMainPage extends BasePage with BlogMainState, BlogMainEvent {
  const BlogMainPage({super.key});

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
      TechtalkAppBar(
        title: '블로그',
        bgColor: AppColor.of.background1,
        padding: const EdgeInsets.only(left: 16, right: 0),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // BounceTapper(
              //   delayedDurationBeforeGrow: const Duration(milliseconds: 25),
              //   onTap: () {
              //     onBlogUploadBtnTapped(context);
              //   },
              //   highlightBorderRadius: BorderRadius.circular(32),
              //   child: Container(
              //     padding: const EdgeInsets.all(16),
              //     child: SvgPicture.asset(
              //       Assets.iconsVideoUpload, // 블로그용 아이콘으로 변경 필요
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      );

  @override
  Color? get screenBackgroundColor => AppColor.of.background1;

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;
}
