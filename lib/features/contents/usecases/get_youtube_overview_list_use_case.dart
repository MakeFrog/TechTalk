import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';

///
/// 유튜브 컨텐츠 리스트를 불러오는 파라미터
///
final class GetYoutubeContentsOverviewsListParams {
  final DocumentSnapshot<YoutubeContentsOverviewModel>? lastDocument;
  final int limit;
  final List<FirestoreQueryConstraint>? queryConstraints;
  final String orderByField;

  GetYoutubeContentsOverviewsListParams({
    required this.limit,
    required this.orderByField,
    this.lastDocument,
    this.queryConstraints,
  });
}

///
/// 유튜브 컨텐츠 리스트 페이이네이션
///
final class GetYoutubeOverviewListUseCase extends BaseUseCase<
    GetYoutubeContentsOverviewsListParams,
    Result<
        FirebasePaginatedResult<YoutubeContentOverviewEntity,
            YoutubeContentsOverviewModel>>> {
  GetYoutubeOverviewListUseCase(this._repository);

  final YoutubeContentsRepository _repository;

  @override
  Future<
      Result<
          FirebasePaginatedResult<YoutubeContentOverviewEntity,
              YoutubeContentsOverviewModel>>> call(
    GetYoutubeContentsOverviewsListParams request,
  ) =>
      _repository.getPagedYoutubeMainContents(
        lastDocument: request.lastDocument,
        limit: request.limit,
        orderByField: request.orderByField,
        queryConstraints: request.queryConstraints,
      );
}
