// youtube_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';

abstract interface class YoutubeRepository {
  ///
  /// 유튜브 API를 통해 동영상 관련 데이터 가져오기
  ///
  Future<Result<YoutubeCoreVideoEntity>> getYoutubeVideoData(
    String videoId,
  );

  ///
  /// 유튜브 API를 통해 [Video] 관련 정보와 caption 정보를 호출하는 메소드
  ///
  Future<Result<YoutubeVideoEntity>> getVideoInfoForUpload(
    String videoId,
  );

  ///
  /// 유튜브 콘텐츠의 요약 정보 호출
  ///
  Future<Result<SummaryEntity>> getYoutubeSummary(String contentId);

  ///
  /// 유튜브 콘텐츠 qna 호출
  ///
  Future<Result<List<YoutubeQnaEntity>>> getQnas(String contentId);

  ///
  /// Firestore로부터 페이징된 유튜브 컨텐츠 개요 목록 가져오기
  ///
  /// [lastDocument] - 다음 페이지의 시작점이 되는 마지막 문서
  /// [limit] - 한 페이지당 가져올 항목 수
  /// [queryConstraints] - 추가적인 Firestore 쿼리 제약 조건
  ///
  Future<
      Result<
          FirebasePaginatedResult<YoutubeContentOverviewEntity,
              YoutubeMainModel>>> getPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  });

  ///
  /// 유튜브 콘텐츠 업로드
  ///
  Future<Result<void>> uploadYoutube({
    required YoutubeContentOverviewEntity contentMainInfo,
    required SummaryEntity summary,
    required Set<YoutubeQnaEntity> qnas,
    required String uploaderId,
    required String uploadLanguageCode,
  });

  Future<Result<YoutubeContentOverviewEntity>> getYoutubeMainInfo(
      {required String contentId});
}
