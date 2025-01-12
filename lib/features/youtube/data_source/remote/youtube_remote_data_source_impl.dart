import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/query_constraints_applier.dart';
import 'package:techtalk/features/tech_set/data_source/remote/job_group_ref.dart';
import 'package:techtalk/features/tech_set/data_source/remote/skill_ref.dart';
import 'package:techtalk/features/user/data_source/remote/users_ref.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_detail_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_qna_model.dart';
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
    required bool hasReversedQueryCallProceeded,
    List<QueryDocumentSnapshot<YoutubeMainModel>>? prevSnapshots,
    required double random,
    required String randomKey,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      Query<YoutubeMainModel> query = _buildInitialQuery(
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        limit: limit,
        randomKey: randomKey,
        randomValue: random,
      );

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // // ConstraintApplier를 사용해서 쿼리 제약사항(필터링) 을 적용함
      if (queryConstraints != null && queryConstraints.isNotEmpty) {
        query = _constraintApplier.applyConstraints<YoutubeMainModel>(
            query, queryConstraints);
      }

      QuerySnapshot<YoutubeMainModel> snapshot = await query.get();

      if (snapshot.docs.isEmpty && hasReversedQueryCallProceeded == true) {
        return FirebasePaginatedResult<YoutubeMainModel, YoutubeMainModel>(
          items: [],
          lastDocument: null,
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }

      if ((prevSnapshots?.length ?? 0) + snapshot.docs.length < limit &&
          hasReversedQueryCallProceeded == false) {
        /// [startAt] 에서 모두 호출을 완료했다면,
        /// 재귀호출하여 [endAt]을 실행
        return getPagedYoutubeMainContents(
          limit: limit,
          orderByField: orderByField,
          hasReversedQueryCallProceeded: true,
          prevSnapshots: snapshot.docs,
          queryConstraints: queryConstraints,
          random: random,
          randomKey: randomKey,
        );
      }

      final targetSnapshots = snapshot.docs;
      if (prevSnapshots != null) {
        targetSnapshots.addAll(prevSnapshots);
      }

      final items = await Future.wait(targetSnapshots.map((doc) async {
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
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
      );
    } catch (e) {
      throw Exception('Failed to fetch Youtube Contents: $e');
    }
  }

  /// 조건별 쿼리
  Query<YoutubeMainModel> _buildInitialQuery({
    required bool hasReversedQueryCallProceeded,
    required String randomKey, // 키 값을 직접 받음
    required double randomValue, // 랜덤 값
    required int limit,
  }) {
    final randomField = 'random.$randomKey'; // 동적 필드 이름 생성

    /// [NOTE]
    /// 이유는 모르겠으나, greateThan, lassThan을 적용하면
    /// exception없이 이상한 값이 반환됨.
    return hasReversedQueryCallProceeded
        ? FirestoreYoutubeRef.collection()
            .where(randomField, isGreaterThanOrEqualTo: randomValue)
            .orderBy(randomField)
            .limit(limit)
        : FirestoreYoutubeRef.collection()
            .where(randomField, isLessThan: randomValue)
            .orderBy(randomField, descending: true)
            .startAt([randomValue]).limit(limit);
  }

  @override
  Future<YoutubeDetailModel> getDetail(String contentId) async {
    try {
      final doc = await FirestoreYoutubeDetailNewRef.doc(contentId).get();

      return doc.data()!;
    } catch (e) {
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
    required String uploaderId,
  }) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      await _updateYoutubeMainInfo(batch, mainInfo: mainInfo);

      await Future.wait([
        _updateQnas(batch, contentId: mainInfo.id, qnas: qnas),
        _updateDetail(batch,
            contentId: mainInfo.id, summary: summary, uploaderId: uploaderId),
        _updateChannel(batch, channel: channel),
        _updateSkillCount(batch, skillIds: mainInfo.relatedSkillIds),
        _updateJobGroupCount(batch, jobGroups: mainInfo.relatedJobGroupIds),
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

  /// 스킬 컬렉션에 count 개수 업데이트
  /// [.set]을 사용하여 기존 데이터가 있다면 엎어 씀.

  Future<void> _updateSkillCount(WriteBatch transaction,
      {required List<String> skillIds}) async {
    for (var skillId in skillIds) {
      // 각 스킬 문서에 count 값을 1씩 증가
      transaction.update(
        FirestoreSkillRef.document(skillId), // skillId를 참조
        {'youtube_content_count': FieldValue.increment(1)}, // count 필드 1 증가
      );
    }
  }

  Future<void> _updateJobGroupCount(WriteBatch transaction,
      {required List<String> jobGroups}) async {
    for (var jobGroupId in jobGroups) {
      // 각 스킬 문서에 count 값을 1씩 증가
      transaction.update(
        FirestoreJobGroupRef.document(jobGroupId), // skillId를 참조
        {'youtube_content_count': FieldValue.increment(1)}, // count 필드 1 증가
      );
    }
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

  /// 유튜브 상세(요약,업로더) 정보 업데이트
  Future<void> _updateDetail(
    WriteBatch transaction, {
    required String contentId,
    required SummaryModel summary,
    required String uploaderId,
  }) async {
    transaction.set(
      FirestoreYoutubeDetailNewRef.doc(contentId),
      YoutubeDetailModel(summary: summary, uploaderId: uploaderId),
    );

    Map<String, dynamic> data = {
      'upload_at': FieldValue.serverTimestamp(),
      'id': contentId,
    };
    transaction.set(
      FirestoreUsersRef.uploadedYoutubeDoc(contentId),
      data,
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
