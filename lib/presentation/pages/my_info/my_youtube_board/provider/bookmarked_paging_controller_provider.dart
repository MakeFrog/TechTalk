import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';

part 'bookmarked_paging_controller_provider.g.dart';

@riverpod
Raw<
    PagingController<DocumentSnapshot<BookmarkedYoutubeModel>?,
        YoutubeMainEntity>> bookmarkedPagingController(
  BookmarkedPagingControllerRef ref,
) {
  final pagingController = PagingController<
      DocumentSnapshot<BookmarkedYoutubeModel>?, YoutubeMainEntity>(
    firstPageKey: null,
  );

  pagingController.addPageRequestListener((pageKey) async {
    final result = await userRepository.getPagedBookmarkedYoutube(
      limit: 15,
      lastDocument: pageKey,
    );

    result.fold(
      onSuccess: (paginatedResult) {
        final newItems = paginatedResult.items;
        final isLastPage = !paginatedResult.hasMore;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = paginatedResult.lastDocument;
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
