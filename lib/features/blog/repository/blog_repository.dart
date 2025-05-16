import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/repository/entity/blog_shell_entity.dart';

abstract interface class BlogRepository {
  Future<Result<FirebasePaginatedResult<BlogShellEntity, BlogMainModel>>>
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
