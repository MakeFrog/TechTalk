import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/pages/youtube/main/provider/selected_filter_category_provider.dart';

mixin class YoutubeMainEvent {
  ///
  /// 유튜브 상세 페이지로 이동
  ///
  void routeToDetailPage(
    WidgetRef ref, {
    required YoutubeMainEntity overview,
  }) {
    final route = YoutubeDetailRoute(
        YoutubeDetailArg.entryFromMainList(overView: overview));
    route.push(ref.context);
  }

  ///
  /// 업로드 버튼이 클릭되었을 때
  /// 영상 업로드 페이지로 이동
  ///
  void onVideoUploadBtnTapped(BuildContext context) {
    const YoutubeLinkSubmitRoute().push(context);
  }

  ///
  /// 컨텐츠 카테고리 chip이 클릭 되었을 때
  ///
  void onCategoryChipTapped(WidgetRef ref,
      {required YoutubeContentCategory targetCategory, required int index}) {
    ref
        .read(youtubeContentCategoryProvider.notifier)
        .toggleCategorySelection(targetCategory);

    final pageController = ref
        .read(youtubeContentCategoryProvider.select((p) => p.pageController));
    pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 1),
      curve: Curves.bounceIn,
    );
  }
}
