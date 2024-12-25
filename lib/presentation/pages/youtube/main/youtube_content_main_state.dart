import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';

import 'provider/youtube_contents_overviews_provider.dart';

mixin class YoutubeContentMainState {
  ///
  /// 페이지네이션 컨트롤러
  ///
  PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
      YoutubeContentOverviewEntity> pagingController(WidgetRef ref) {
    final pagingController = ref.watch(youtubeContentsOverviewsProvider);
    return pagingController;
  }
}
