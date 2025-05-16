import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';
import 'package:techtalk/features/blog/repository/blog_repository.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource _remoteDataSource;

  BlogRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<FirebasePaginatedResult<BlogShellEntity, BlogShellEntity>>>
      getRandomPagedBlogContents({
    required DocumentSnapshot<BlogShellEntity>? lastDocument,
    required int limit,
    required String orderByField,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      final result = await _remoteDataSource.getRandomPagedBlogContents(
        lastDocument: lastDocument,
        limit: limit,
        orderByField: orderByField,
        queryConstraints: queryConstraints,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        random: random,
        randomKey: randomKey,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
