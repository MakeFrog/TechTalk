import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';

mixin class YoutubeContentsMainListEvent {
  void routeToDetailPage(
    BuildContext context, {
    required ContentsOverviewEntity overview,
  }) {
    final route = ContentsDetailRoute(overview);
    route.push(context);
  }
}
