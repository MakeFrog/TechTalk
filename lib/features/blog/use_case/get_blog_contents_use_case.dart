import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/blog_repository.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

///
/// 블로그 컨텐츠 리스트를 불러오는 파라미터
///
final class GetBlogContentsOverviewsListParams {
  final DocumentSnapshot<BlogMainModel>? lastDocument;
  final int limit;
  final List<FirestoreQueryConstraint>? queryConstraints;
  final String orderByField;
  final bool isHalfOfRandomCalled;
  final double random;
  final String randomKey;

  GetBlogContentsOverviewsListParams({
    required this.limit,
    required this.orderByField,
    required this.isHalfOfRandomCalled,
    required this.random,
    required this.randomKey,
    this.lastDocument,
    this.queryConstraints,
  });
}

///
/// 블로그 컨텐츠 리스트 페이지네이션
///
final class GetBlogOverviewListUseCase extends BaseUseCase<
    GetBlogContentsOverviewsListParams,
    Result<FirebasePaginatedResult<BlogShellEntity, BlogMainModel>>> {
  GetBlogOverviewListUseCase(this._repository);

  final BlogRepository _repository;

  @override
  Future<Result<FirebasePaginatedResult<BlogShellEntity, BlogMainModel>>> call(
    GetBlogContentsOverviewsListParams request,
  ) async {
    try {
      DocumentSnapshot<BlogShellEntity>? convertedLastDocument;
      if (request.lastDocument != null) {
        final snapshot = await request.lastDocument!.reference
            .withConverter(
              fromFirestore: BlogShellEntity.fromFirestore,
              toFirestore: (value, options) => value.toFirestore(),
            )
            .get();
        convertedLastDocument = snapshot;
      }

      final result = await _repository.getRandomPagedBlogContents(
        lastDocument: convertedLastDocument,
        limit: request.limit,
        orderByField: request.orderByField,
        queryConstraints: request.queryConstraints,
        hasReversedQueryCallProceeded: request.isHalfOfRandomCalled,
        random: request.random,
        randomKey: request.randomKey,
      );
      return result;
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
