import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/bookmarked_paging_controller_provider.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/show_upload_floating_button_provider.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/uploaded_history_paging_controller_provider.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/watched_history_paging_controller_provider.dart';

mixin class MyYoutubeBoardState {
  ///
  /// 시청 기록 페이징 컨트롤러
  ///
  PagingController<DocumentSnapshot<WatchedYoutubeModel>?, YoutubeMainEntity>
      watchedHistoryPagingControllerState(WidgetRef ref) =>
          ref.watch(watchedHistoryPagingControllerProvider);

  ///
  /// 북마크 기록 페이징 컨트롤러
  ///
  PagingController<DocumentSnapshot<BookmarkedYoutubeModel>?, YoutubeMainEntity>
      bookmarkedPagingControllerState(WidgetRef ref) =>
          ref.watch(bookmarkedPagingControllerProvider);

  ///
  /// 업로드 기록 페이징 컨트롤러
  ///
  PagingController<DocumentSnapshot<UploadedYoutubeModel>?, YoutubeMainEntity>
      uploadedHistoryPagingControllerState(WidgetRef ref) =>
          ref.watch(uploadedHistoryPagingControllerProvider);

  bool showUploadFloatingButtonState(WidgetRef ref) =>
      ref.watch(showUploadFloatingButtonProvider);
}
