import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';

///
/// 유튜브 컨텐츠 리스트를 불러오는 파라미터
///
final class GetYoutubeContentsOverviewsListParams {
  final DocumentSnapshot<YoutubeMainModel>? lastDocument;
  final int limit;
  final List<FirestoreQueryConstraint>? queryConstraints;
  final String orderByField;
  final bool isHalfOfRandomCalled;
  final double random;

  GetYoutubeContentsOverviewsListParams({
    required this.limit,
    required this.orderByField,
    required this.isHalfOfRandomCalled,
    required this.random,
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
            YoutubeMainModel>>> {
  GetYoutubeOverviewListUseCase(this._repository);

  final YoutubeRepository _repository;

  @override
  Future<
      Result<
          FirebasePaginatedResult<YoutubeContentOverviewEntity,
              YoutubeMainModel>>> call(
    GetYoutubeContentsOverviewsListParams request,
  ) =>
      _repository.getPagedYoutubeMainContents(
        lastDocument: request.lastDocument,
        limit: request.limit,
        orderByField: request.orderByField,
        queryConstraints: request.queryConstraints,
        hasReversedQueryCallProceeded: request.isHalfOfRandomCalled,
        random: request.random,
      );
}
