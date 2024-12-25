// lib/providers/youtube_contents_overviews_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_overview_list_use_case.dart';
import 'package:techtalk/features/contents/youtube.dart';
import 'package:techtalk/presentation/pages/youtube/main/constant/yotubue_content_category.dart';

part 'youtube_contents_overviews_provider.g.dart';

@riverpod
Raw<
    PagingController<DocumentSnapshot<YoutubeContentsOverviewModel>?,
        YoutubeContentOverviewEntity>> youtubeContentsOverviews(
  YoutubeContentsOverviewsRef ref, {
  required YoutubeContentCategory filterArg,
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
      queryConstraints: [
        ArrayContainsAnyConstraint(
            fieldPath: 'related_skill_ids', values: ['android']),
      ],
    );

    final result = await getYoutubeOverviewListUseCase.call(params);

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
