// youtube_contents_repository_impl.dart

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeContentsRepositoryImpl implements YoutubeContentsRepository {
  YoutubeContentsRepositoryImpl(this._youtubeApiDataSource, this._youtubeRemoteDataSource);

  final YoutubeExplode _youtubeApiDataSource;
  final YoutubeContentsRemoteDataSource _youtubeRemoteDataSource;

  @override
  Future<Result<YouTubeVideoDataEntity>> getYoutubeVideoData(String videoId) async {
    try {
      final video = await _youtubeApiDataSource.videos.get(videoId);
      final channel = await _youtubeApiDataSource.channels.get(video.channelId);

      return Result.success(
        YouTubeVideoDataEntity(
          id: video.id.value,
          url: video.url,
          title: video.title,
          thumnailSet: video.thumbnails,
          engagement: video.engagement,
          channelInfo: channel,
        ),
      );
    } on Exception catch (e) {
      log('getYoutubeVideoData : $e');
      return Result.failure(
        const FetchYoutubeContentsException(),
      );
    }
  }

  @override
  Future<Result<YoutubeContentsDetailEntity>> getYoutubeContentsDetail(String videoId) async {
    try {
      final remoteResponse = await _youtubeRemoteDataSource.getYoutubeContentsDetail(videoId);

      return Result.success(remoteResponse.toEntity());
    } on Exception catch (e) {
      log('getYoutubeContentsDetail : $e');
      return Result.failure(
        const FetchYoutubeContentsDetailException(),
      );
    }
  }

  @override
  Future<Result<List<QnaEntity>>> getYoutubeContentsDetailQnas(String videoId) async {
    try {
      final remoteResponse = await _youtubeRemoteDataSource.getYoutubeContentsDetailQnas(videoId);

      return Result.success(remoteResponse.map((data) => data.toEntity()).toList());
    } on Exception catch (e) {
      log('getYoutubeContentsDetailQnas : $e');
      return Result.failure(
        const FetchYoutubeContentsQnaException(),
      );
    }
  }

  @override
  Future<Result<FirebasePaginatedResult<YoutubeContentsOverviewEntity, YoutubeContentsOverviewModel>>>
      getYoutubeContentsOverviews({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeContentsOverviewModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      // Remote DataSource에서 페이징된 데이터 가져오기
      final remotePaginatedResult = await _youtubeRemoteDataSource.getYoutubeContentsOverviews(
        limit: limit,
        orderByField: orderByField,
        lastDocument: lastDocument,
        queryConstraints: queryConstraints,
      );

      // 모델을 엔티티로 변환
      final entities = remotePaginatedResult.items.map((model) => model.toEntity()).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult = FirebasePaginatedResult<YoutubeContentsOverviewEntity, YoutubeContentsOverviewModel>(
        items: entities,
        lastDocument: remotePaginatedResult.lastDocument,
        hasMore: remotePaginatedResult.hasMore,
      );

      return Result.success(paginatedResult);
    } on Exception catch (e) {
      log('getYoutubeContentsOverviews : $e');
      return Result.failure(
        const FetchYoutubeContentsOverviewException(),
      );
    }
  }
}
