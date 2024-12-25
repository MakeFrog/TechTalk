import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';
import 'package:techtalk/presentation/pages/youtube/main/provider/selected_filter_category_provider.dart';

mixin class YoutubeContentMainEvent {
  ///
  /// 유튜브 상세 페이지로 이동
  ///
  void routeToDetailPage(
    BuildContext context, {
    required YoutubeContentOverviewEntity overview,
  }) {
    final route = ContentsDetailRoute(overview);
    route.push(context);
  }

  ///
  /// 컨텐츠 카테고리 chip이 클릭 되었을 때
  ///
  void onCategoryChipTapped(WidgetRef ref,
      {required YoutubeContentCategory targetCategory}) {
    ref
        .read(youtubeContentCategoryProvider.notifier)
        .toggleCategorySelection(targetCategory);
  }
}
