import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';

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
}
