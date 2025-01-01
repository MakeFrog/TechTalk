import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_overview_list_use_case.dart';
import 'package:techtalk/features/contents/index.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';

part 'youtube_content_pagination_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<
    PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
        YoutubeContentOverviewEntity>> youtubeContentPagination(
  YoutubeContentPaginationRef ref, {
  required YoutubeContentCategory category,
}) {
  final pagingController = PagingController<
      DocumentSnapshot<YoutubeContentsOverviewModel>?,
      YoutubeContentOverviewEntity>(
    firstPageKey: null,
  );

  // 페이지 요청 리스너 추가
  pagingController.addPageRequestListener((pageKey) async {
    // TODO: 추후 필터 UI 구현되면 선택한 파라미터로 구성하도록 변경 필요
    final params = GetYoutubeContentsOverviewsListParams(
      lastDocument: pageKey,
      limit: 10,
      orderByField: 'upload_at',
      queryConstraints: !category.type.isAll
          ? [
              // '전체' 카테고리가 아닐 경우 '필터링' 항목 설정
              ArrayContainsAnyConstraint(
                fieldPath: category.type.documentFieldName,
                values: [
                  category.id,
                ],
              ),
            ]
          : null,
    );

    final result = await getYoutubeOverviewListUseCase.call(params);

    result.fold(
      onSuccess: (paginatedResult) {
        final newItems = paginatedResult.items;
        final isLastPage = !paginatedResult.hasMore;

        if (isLastPage) {
          print('마지막 페이징 호출');
          pagingController.appendLastPage(newItems);
        } else {
          print('일반 페이징 호출');
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
