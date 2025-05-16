import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

abstract class BlogRemoteDataSource {
  Future<FirebasePaginatedResult<BlogShellEntity, BlogShellEntity>>
      getPagedBlogContents({
    required DocumentSnapshot<BlogShellEntity>? lastDocument,
    required int limit,
    required String orderByField,
    List<FirestoreQueryConstraint>? queryConstraints,
  });

  Future<FirebasePaginatedResult<BlogShellEntity, BlogShellEntity>>
      getRandomPagedBlogContents({
    required DocumentSnapshot<BlogShellEntity>? lastDocument,
    required int limit,
    required String orderByField,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
    List<FirestoreQueryConstraint>? queryConstraints,
  });
}
