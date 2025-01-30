import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';

part 'youtube_content_pagination_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>>
    youtubeContentPagination(
  YoutubeContentPaginationRef ref, {
  required YoutubeContentCategory category,
}) {
  final pagingController =
      PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>(
    firstPageKey: null,
  );

  bool hasReversedQueryCallProceeded = false;

  final random = Random();
  final randomValue = random.nextDouble();
  final randomKey = (random.nextInt(5) + 1).toString();

  // 페이지 요청 리스너 추가
  pagingController.addPageRequestListener((pageKey) async {
    // TODO: 추후 필터 UI 구현되면 선택한 파라미터로 구성하도록 변경 필요
    final params = GetYoutubeContentsOverviewsListParams(
      lastDocument: pageKey,
      limit: 15,
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
      isHalfOfRandomCalled: hasReversedQueryCallProceeded,
      random: randomValue,
      randomKey: randomKey,
    );

    final result = await getYoutubeOverviewListUseCase.call(params);

    result.fold(
      onSuccess: (paginatedResult) {
        final newItems = paginatedResult.items..shuffle();
        final isLastPage =
            !paginatedResult.hasMore && hasReversedQueryCallProceeded;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = paginatedResult.lastDocument;
          pagingController.appendPage(newItems, nextPageKey);
        }

        if (paginatedResult.hasReversedQueryCallProceeded == true) {
          hasReversedQueryCallProceeded = true;
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
