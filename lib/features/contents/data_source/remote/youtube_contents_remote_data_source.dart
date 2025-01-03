import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_detail_new_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_qna_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/topic/topic.dart';

/// 유튜브 컨텐츠 관련 원격 데이터 소스 인터페이스
abstract interface class YoutubeContentsRemoteDataSource {
  ///
  /// 특정 유튜브 컨텐츠의 상세 정보를 가져옵니다.
  ///
  /// [contentsId] - 조회할 컨텐츠의 고유 ID
  ///
  @Deprecated('[YoutubeContentsDetailNewModel]로 교체 예정')
  Future<YoutubeContentsDetailModel> getYoutubeContentsDetail(
      String contentsId);

  ///
  /// 유튜브 콘텐츠 qna 호출
  ///
  Future<List<YoutubeQnaModel>> getQnas(String contentId);

  ///
  /// 유튜브 콘텐츠 상세 정보 호출
  /// (현재는 상세 정보에 요약 정보밖에 존재하지 않음)
  ///
  Future<YoutubeContentsDetailNewModel> getDetail(String contentId);

  ///
  /// 특정 유튜브 컨텐츠와 관련된 질문 목록을 가져옵니다.
  ///
  /// [contentsId] - 조회할 컨텐츠의 고유 ID
  ///
  Future<List<TopicQnaModel>> getYoutubeContentsDetailQnas(String contentsId);

  ///
  /// Firestore로부터 페이징된 유튜브 컨텐츠 개요 목록을 가져옵니다.
  ///
  /// [lastDocument] - 다음 페이지의 시작점이 되는 마지막 문서
  /// [limit] - 한 페이지당 가져올 항목 수
  /// [queryConstraints] - 추가적인 쿼리 제약 조건
  ///
  Future<
      FirebasePaginatedResult<YoutubeContentsOverviewModel,
          YoutubeContentsOverviewModel>> getYoutubeContentsOverviews({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeContentsOverviewModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  });
}
