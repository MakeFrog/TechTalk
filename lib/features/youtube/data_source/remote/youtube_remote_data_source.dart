import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_detail_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_qna_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';

/// 유튜브 컨텐츠 관련 원격 데이터 소스 인터페이스
abstract interface class YoutubeRemoteDataSource {
  ///
  /// 유튜브 콘텐츠 qna 호출
  ///
  Future<List<YoutubeQnaModel>> getQnas(String contentId);

  ///
  /// 유튜브 콘텐츠 상세 정보 호출
  /// (현재는 상세 정보에 요약 정보밖에 존재하지 않음)
  ///
  Future<YoutubeDetailModel> getDetail(String contentId);

  ///
  /// Firestore로부터 페이징된 유튜브 컨텐츠 개요 목록을 가져옵니다.
  ///
  /// [lastDocument] - 다음 페이지의 시작점이 되는 마지막 문서
  /// [limit] - 한 페이지당 가져올 항목 수
  /// [queryConstraints] - 추가적인 쿼리 제약 조건
  ///
  Future<FirebasePaginatedResult<YoutubeMainModel, YoutubeMainModel>>
      getPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  });

  ///
  /// 유튜브 콘텐츠 업로드
  ///
  Future<void> uploadYoutube({
    required ChannelModel channel,
    required List<YoutubeQnaModel> qnas,
    required YoutubeMainModel mainInfo,
    required SummaryModel summary,
  });

  ///
  /// 유튜브 콘텐츠가 이미지 업로드되어 있는지 여부
  ///
  Future<bool> isYoutubeAlreadyUploaded(String contentId);

  ///
  /// 유튜브 메인 콘텐츠 정호 호출 (단일)
  ///
  Future<YoutubeMainModel> getSingleYoutubeMainContent({
    required String contentId,
  });
}
