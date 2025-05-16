import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';

abstract class BlogRemoteDataSource {
  Future<FirebasePaginatedResult<BlogMainModel, BlogMainModel>>
      getPagedBlogContents({
    required DocumentSnapshot<BlogMainModel>? lastDocument,
    required int limit,
    required String orderByField,
    List<FirestoreQueryConstraint>? queryConstraints,
  });

  Future<FirebasePaginatedResult<BlogMainModel, BlogMainModel>>
      getRandomPagedBlogContents({
    required DocumentSnapshot<BlogMainModel>? lastDocument,
    required int limit,
    required String orderByField,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
    List<FirestoreQueryConstraint>? queryConstraints,
  });
}
