import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/company_model.dart';

abstract class BlogRemoteDataSource {
  ///
  /// 블로그 콘텐츠 리스트 페이지네이션 호출
  ///
  Future<FirebasePaginatedResult<BlogMainModel, BlogMainModel>>
      getPagedBlogContents({
    required DocumentSnapshot<BlogMainModel>? lastDocument,
    required int limit,
    required String orderByField,
    List<FirestoreQueryConstraint>? queryConstraints,
  });

  ///
  /// 블로그 콘텐츠 리스트 '랜덤' 페이지네이션 호출
  ///
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

  ///
  /// Company 컬렉션에서 회사 리스트 조회
  ///
  Future<List<CompanyModel>> getCompanyList();
}
