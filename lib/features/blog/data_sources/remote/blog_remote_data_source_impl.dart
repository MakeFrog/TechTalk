import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';
import 'package:techtalk/features/blog/data_sources/remote/models/blog_main_model.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore _firestore;
  static const String _collectionName = 'Blogs';

  BlogRemoteDataSourceImpl(this._firestore);

  @override
  Future<FirebasePaginatedResult<BlogMainModel, BlogMainModel>>
      getRandomPagedBlogContents({
    required DocumentSnapshot<BlogMainModel>? lastDocument,
    required int limit,
    required String orderByField,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      Query<BlogMainModel> query = _buildInitialQuery(
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        limit: limit,
        randomKey: randomKey,
        randomValue: random,
      );

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      if (queryConstraints != null && queryConstraints.isNotEmpty) {
        for (final constraint in queryConstraints) {
          query = constraint.apply(query);
        }
      }

      final snapshot = await query.get();
      print('Blog Query Result: ${snapshot.docs.length} items'); // 디버그 로그

      if (snapshot.docs.isEmpty && hasReversedQueryCallProceeded) {
        return FirebasePaginatedResult<BlogMainModel, BlogMainModel>(
          items: [],
          lastDocument: null,
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }

      if (snapshot.docs.length < limit && !hasReversedQueryCallProceeded) {
        // 역방향 쿼리 수행
        return getRandomPagedBlogContents(
          limit: limit,
          orderByField: orderByField,
          hasReversedQueryCallProceeded: true,
          queryConstraints: queryConstraints,
          random: random,
          randomKey: randomKey,
          lastDocument: null,
        );
      }

      final items = snapshot.docs.map((e) => e.data()).toList()..shuffle();
      final hasMore = snapshot.docs.length >= limit;

      return FirebasePaginatedResult<BlogMainModel, BlogMainModel>(
        items: items,
        lastDocument: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
        hasMore: hasMore,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
      );
    } catch (error) {
      print('Blog Query Error: $error'); // 디버그 로그
      rethrow;
    }
  }

  /// 조건별 쿼리
  Query<BlogMainModel> _buildInitialQuery({
    required bool hasReversedQueryCallProceeded,
    required String randomKey,
    required double randomValue,
    required int limit,
  }) {
    final randomField = 'random.$randomKey';
    final query = _firestore
        .collection(_collectionName)
        .withConverter(
          fromFirestore: BlogMainModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .where('is_valid', isEqualTo: true);

    if (!hasReversedQueryCallProceeded) {
      return query
          .where(randomField, isLessThan: randomValue)
          .orderBy(randomField, descending: true)
          .startAt([randomValue]).limit(limit);
    }

    return query
        .where(randomField, isGreaterThanOrEqualTo: randomValue)
        .orderBy(randomField)
        .limit(limit);
  }

  @override
  Future<FirebasePaginatedResult<BlogMainModel, BlogMainModel>>
      getPagedBlogContents({
    required DocumentSnapshot<BlogMainModel>? lastDocument,
    required int limit,
    required String orderByField,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    Query<BlogMainModel> query = _firestore
        .collection(_collectionName)
        .withConverter(
          fromFirestore: BlogMainModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .where('is_valid', isEqualTo: true);

    // 쿼리 제약 조건 적용
    if (queryConstraints != null) {
      for (final constraint in queryConstraints) {
        query = constraint.apply(query);
      }
    }

    // 정렬 및 페이지네이션 적용
    query = query.orderBy(orderByField, descending: true).limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    final items = querySnapshot.docs.map((e) => e.data()).toList();
    final hasMore = items.length >= limit;

    return FirebasePaginatedResult(
      items: items,
      lastDocument: querySnapshot.docs.isEmpty ? null : querySnapshot.docs.last,
      hasMore: hasMore,
      hasReversedQueryCallProceeded: false,
    );
  }
}
