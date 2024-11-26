import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/core/query_constraints_applier.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_detail_ref.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_overview_ref.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/topic/topic.dart';

final class YoutubeContentsRemoteDataSourceImpl implements YoutubeContentsRemoteDataSource {
  final QueryConstraintApplier _constraintApplier;

  YoutubeContentsRemoteDataSourceImpl(this._constraintApplier);

  @override
  Future<YoutubeContentsDetailModel> getYoutubeContentsDetail(String contentsId) async {
    final detailDoc = await FirestoreYoutubeDetailRef.doc(contentsId).get();

    if (!detailDoc.exists) {
      throw const FetchYoutubeContentsDetailException();
    }

    return detailDoc.data()!;
  }

  @override
  Future<List<TopicQnaModel>> getYoutubeContentsDetailQnas(String contentsId) async {
    final collection = await FirestoreYoutubeDetailQuestionRef.collection(contentsId).get();

    return collection.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<FirebasePaginatedResult<YoutubeContentsOverviewModel, YoutubeContentsOverviewModel>>
      getYoutubeContentsOverviews({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeContentsOverviewModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      Query<YoutubeContentsOverviewModel> query =
          FirestoreYoutubeContentsOverviewRef.collection().orderBy(orderByField).limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // ConstraintApplier를 사용해서 쿼리 제약사항(필터링) 을 적용함
      if (queryConstraints != null && queryConstraints.isNotEmpty) {
        query = _constraintApplier.applyConstraints(query, queryConstraints);
      }

      QuerySnapshot<YoutubeContentsOverviewModel> snapshot = await query.get();

      final items = snapshot.docs.map((doc) => doc.data()).toList();
      final hasMore = snapshot.docs.length == limit;
      final newLastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      if (newLastDocument == null && items.isNotEmpty) {
        throw Exception('Last document is null after fetching data.');
      }

      return FirebasePaginatedResult<YoutubeContentsOverviewModel, YoutubeContentsOverviewModel>(
        items: items,
        lastDocument: newLastDocument!,
        hasMore: hasMore,
      );
    } catch (e) {
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }
}
