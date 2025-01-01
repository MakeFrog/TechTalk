import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/query_constraints_applier.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_detail_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_qna_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/youtube_ref.dart';
import 'package:techtalk/features/youtube/data_source/remote/youtube_remote_data_source.dart';

final class YoutubeRemoteDataSourceImpl implements YoutubeRemoteDataSource {
  final QueryConstraintApplier _constraintApplier;

  YoutubeRemoteDataSourceImpl(this._constraintApplier);

  @override
  Future<FirebasePaginatedResult<YoutubeMainModel, YoutubeMainModel>>
      getPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      Query<YoutubeMainModel> query =
          FirestoreYoutubeRef.collection().orderBy(orderByField).limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // ConstraintApplier를 사용해서 쿼리 제약사항(필터링) 을 적용함
      if (queryConstraints != null && queryConstraints.isNotEmpty) {
        query = _constraintApplier.applyConstraints(query, queryConstraints);
      }

      QuerySnapshot<YoutubeMainModel> snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return FirebasePaginatedResult<YoutubeMainModel, YoutubeMainModel>(
          items: [],
          lastDocument: null,
          hasMore: false,
        );
      }

      final items = await Future.wait(snapshot.docs.map((doc) async {
        final targetData = doc.data();

        // channel_ref를 통해 [ChannelModel] 데이터를 가져옴
        final channelSnapshot = await targetData.channelRef?.get()
            as DocumentSnapshot<Map<String, dynamic>>; // 타입 캐스팅
        final channelModel = ChannelModel.fromFirestore(channelSnapshot, null);

        return targetData.copyWith(channel: channelModel);
      }).toList());

      final hasMore = snapshot.docs.length == limit;
      final newLastDocument =
          snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      if (newLastDocument == null && items.isNotEmpty) {
        throw Exception('Last document is null after fetching data.');
      }

      return FirebasePaginatedResult<YoutubeMainModel, YoutubeMainModel>(
        items: items,
        lastDocument: newLastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }

  @override
  Future<YoutubeDetailModel> getDetail(String contentId) async {
    try {
      final doc = await FirestoreYoutubeDetailNewRef.doc(contentId).get();

      return doc.data()!;
    } catch (e) {
      print('이씨방 : ${e}');
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }

  @override
  Future<List<YoutubeQnaModel>> getQnas(String contentId) async {
    try {
      final collection =
          await FirestoreYoutubeQnaRef.collection(contentId).get();

      return collection.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }

  @override
  Future<void> uploadYoutube({
    required ChannelModel channel,
    required List<YoutubeQnaModel> qnas,
    required YoutubeMainModel mainInfo,
    required SummaryModel summary,
  }) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      await _updateYoutubeMainInfo(batch, mainInfo: mainInfo);

      await Future.wait([
        _updateQnas(batch, contentId: mainInfo.id, qnas: qnas),
        _updateSummary(batch, contentId: mainInfo.id, summary: summary),
        _updateChannel(batch, channel: channel)
      ]);
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }

  /// 채널정보 업데이트
  /// [.set]을 사용하여 기존 데이터가 있다면 엎어 씀.
  Future<void> _updateChannel(WriteBatch transaction,
      {required ChannelModel channel}) async {
    transaction.set(
      FirestoreYoutubeChannelRef.document(channel.id),
      channel,
    );
  }

  /// 문답 리스트 업데이트
  Future<void> _updateQnas(
    WriteBatch batch, {
    required String contentId,
    required List<YoutubeQnaModel> qnas,
  }) async {
    for (var e in qnas) {
      batch.set(
        FirestoreYoutubeQnaRef.collection(contentId).doc(e.id).withConverter(
            fromFirestore: YoutubeQnaModel.fromFirestore,
            toFirestore: (value, _) => value.toJson()),
        e,
      );
    }
  }

  /// 유튜브 메인 정보 업데이트
  Future<void> _updateYoutubeMainInfo(
    WriteBatch transaction, {
    required YoutubeMainModel mainInfo,
  }) async {
    transaction.set(
      FirestoreYoutubeRef.doc(mainInfo.id),
      mainInfo,
    );
  }

  /// 유튜브 메인 정보 업데이트
  Future<void> _updateSummary(
    WriteBatch transaction, {
    required String contentId,
    required SummaryModel summary,
  }) async {
    transaction.set(
      FirestoreYoutubeDetailNewRef.doc(contentId),
      YoutubeDetailModel(summary: summary),
    );
  }

  @override
  Future<bool> isYoutubeAlreadyUploaded(String contentId) async {
    final doc = await FirestoreYoutubeRef.doc(contentId).get();
    return doc.exists;
  }

  @override
  Future<YoutubeMainModel> getSingleYoutubeMainContent(
      {required String contentId}) async {
    try {
      final doc = await FirestoreYoutubeRef.doc(contentId).get();
      final targetDoc = doc.data();
      if (targetDoc == null) {
        throw Exception('콘텐츠가 존재하지 않음');
      }
      // channel_ref를 통해 [ChannelModel] 데이터를 가져옴
      final channelSnapshot = await targetDoc.channelRef?.get()
          as DocumentSnapshot<Map<String, dynamic>>; // 타입 캐스팅
      final channelModel = ChannelModel.fromFirestore(channelSnapshot, null);

      return targetDoc.copyWith(channel: channelModel);
    } catch (e) {
      rethrow;
    }
  }
}
