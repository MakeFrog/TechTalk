import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';

part 'watched_history_paging_controller_provider.g.dart';

@riverpod
Raw<PagingController<DocumentSnapshot<WatchedYoutubeModel>?, YoutubeMainEntity>>
    watchedHistoryPagingController(WatchedHistoryPagingControllerRef ref) {
  final pagingController = PagingController<
      DocumentSnapshot<WatchedYoutubeModel>?, YoutubeMainEntity>(
    firstPageKey: null,
  );

  pagingController.addPageRequestListener((pageKey) async {
    final result = await userRepository.getPagedWatchedYoutubeHistory(
      limit: 15,
      lastDocument: pageKey,
    );

    result.fold(
      onSuccess: (paginatedResult) {
        final newItems = paginatedResult.items;
        final isLastPage = !paginatedResult.hasMore;

        if (isLastPage) {
          print('마지막 페이징 ');
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = paginatedResult.lastDocument;
          print('일반 페이징 : ${nextPageKey?.get('id')}');
          pagingController.appendPage(newItems, nextPageKey);
        }
      },
      onFailure: (error) {
        pagingController.error = error;
      },
    );
  });

  // Provider가 dispose될 때 PagingController도 dispose
  ref.onDispose(pagingController.dispose);

  return pagingController;
}
