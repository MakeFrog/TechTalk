import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'channel_contents_pagination_provider.g.dart';

@riverpod
Raw<PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>>
    channelContentsPagination(ChannelContentsPaginationRef ref,
        {required String channelId}) {
  final pagingController =
      PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>(
    firstPageKey: null,
  );

  // 페이지 요청 리스너 추가
  pagingController.addPageRequestListener((pageKey) async {
    final response = await youtubeRepository.getPagedYoutubeMainContents(
        limit: 15,
        orderByField: 'upload_at',
        fetchChannel: false,
        lastDocument: pageKey,
        queryConstraints: [
          EqualToConstraint(
            fieldName: 'channel_ref',
            value: FirebaseFirestore.instance.doc('/Channel/$channelId'),
          ),
        ]);

    response.fold(
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
