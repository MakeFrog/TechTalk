import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/constant/youtube_board_tab_type.enum.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/my_youtube_board_state.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/item/youtube_content_item_view.dart';
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
    return PagedListView<DocumentSnapshot<WatchedYoutubeContent>?,
        WatchedYoutubeContent>(
      pagingController: aimPagingController(ref),
      // physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<WatchedYoutubeContent>(
        itemBuilder: (context, item, index) {
          final newItem = item.info;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: BounceTapper(
              onTap: () {},
              child: YoutubeContentItemView(
                thumbnailImgUrl: newItem.thumbnailImgUrl,
                title: 'newItem.contentsTitle',
                channelName: 'newItem.channel.name',
                videoDuration: newItem.videoDuration,
                questionCount: newItem.qnaNum,
                skills: [],
                jobGroups: [],
                videoId: newItem.id,
              ),
            ),
          );
        },
        // firstPageProgressIndicatorBuilder: (_) => _buildLoadView(),
        // newPageProgressIndicatorBuilder: (_) =>
        // const Center(child: CircularProgressIndicator()),
        // firstPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // newPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // noItemsFoundIndicatorBuilder: _buildNoItemFoundView,
      ),
    );
    return PagedListView<DocumentSnapshot<YoutubeMainModel>?,
        YoutubeMainEntity>(
      pagingController: pagingController(ref),
      builderDelegate: PagedChildBuilderDelegate<YoutubeMainEntity>(
        itemBuilder: (context, item, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: BounceTapper(
              onTap: () {},
              child: YoutubeContentItemView(
                thumbnailImgUrl: item.thumbnailImgUrl,
                title: item.contentsTitle,
                channelName: item.channel.name,
                videoDuration: item.videoDuration,
                questionCount: item.qnaNum,
                skills: item.relatedSkillIds.toList(),
                jobGroups: item.relatedJobs.toList(),
                videoId: item.id,
              ),
            ),
          );
        },
        // firstPageProgressIndicatorBuilder: (_) => _buildLoadView(),
        // newPageProgressIndicatorBuilder: (_) =>
        // const Center(child: CircularProgressIndicator()),
        // firstPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // newPageErrorIndicatorBuilder: (_) =>
        //     _buildErrorOccuredView(targetController),
        // noItemsFoundIndicatorBuilder: _buildNoItemFoundView,
      ),
    );
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
