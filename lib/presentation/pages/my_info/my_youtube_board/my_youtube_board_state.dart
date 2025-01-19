import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/watched_history_paging_controller_provider.dart';

mixin class MyYoutubeBoardState {
  ///
  /// 시청 기록 페이징 컨트롤러
  ///
  PagingController<DocumentSnapshot<WatchedYoutubeContent>?,
      WatchedYoutubeContent> aimPagingController(
          WidgetRef ref) =>
      ref.watch(watchedHistoryPagingControllerProvider);
}
