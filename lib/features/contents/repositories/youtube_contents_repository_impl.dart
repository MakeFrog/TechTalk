// youtube_contents_repository_impl.dart

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/data_source/remote/models/contents_author_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_qna_model.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_video_contents_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/contents/repositories/entities/contents_overview_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_entity.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';
import 'package:techtalk/features/contents/usecases/exception/youtube_upload_exception.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeContentsRepositoryImpl implements YoutubeContentsRepository {
  YoutubeContentsRepositoryImpl(this._youtubeApiDataSource,
      this._youtubeRemoteDataSource, this._techSetRepository);

  final YoutubeExplode _youtubeApiDataSource;
  final YoutubeContentsRemoteDataSource _youtubeRemoteDataSource;
  final TechSetRepository _techSetRepository;

  @override
  Future<Result<YouTubeVideoDataEntity>> getYoutubeVideoData(
      String videoId) async {
    try {
      final Video video = await _youtubeApiDataSource.videos.get(videoId);
      final Channel channel =
          await _youtubeApiDataSource.channels.get(video.channelId);

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
  Future<Result<YoutubeContentsDetailEntity>> getYoutubeContentsDetail(
      String videoId) async {
    try {
      final remoteResponse =
          await _youtubeRemoteDataSource.getYoutubeContentsDetail(videoId);

      return Result.success(remoteResponse.toEntity());
    } on Exception catch (e) {
      log('getYoutubeContentsDetail : $e');
      return Result.failure(
        const FetchYoutubeContentsDetailException(),
      );
    }
  }

  @override
  Future<Result<List<YoutubeQnaEntity>>> getYoutubeContentsDetailQnas(
      String videoId) async {
    try {
      final remoteResponse =
          await _youtubeRemoteDataSource.getYoutubeContentsDetailQnas(videoId);

      return Result.success(
          remoteResponse.map(YoutubeQnaEntity.fromModel).toList());
    } on Exception catch (e) {
      log('getYoutubeContentsDetailQnas : $e');
      return Result.failure(
        const FetchYoutubeContentsQnaException(),
      );
    }
  }

  @override
  Future<
      Result<
          FirebasePaginatedResult<YoutubeContentOverviewEntity,
              YoutubeContentsOverviewModel>>> getPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeContentsOverviewModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
  }) async {
    try {
      // Remote DataSource에서 페이징된 데이터 가져오기
      final remotePaginatedResult =
          await _youtubeRemoteDataSource.getPagedYoutubeMainContents(
        limit: limit,
        orderByField: orderByField,
        lastDocument: lastDocument,
        queryConstraints: queryConstraints,
      );

      // 모델을 엔티티로 변환
      final entities = remotePaginatedResult.items.map((model) {
        final skills =
            model.relatedSkillIds.map(_techSetRepository.getSkillById).toList();
        return model.toEntity(skills);
      }).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult = FirebasePaginatedResult<
          YoutubeContentOverviewEntity, YoutubeContentsOverviewModel>(
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

  @override
  Future<Result<SummaryEntity>> getYoutubeSummary(String contentId) async {
    try {
      final response = await _youtubeRemoteDataSource.getDetail(contentId);

      final result = response.summary.toEntity();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<YoutubeQnaEntity>>> getQnas(String contentId) async {
    try {
      final response = await _youtubeRemoteDataSource.getQnas(contentId);
      final result = response.map((e) => e.toEntity()).toList();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<YoutubeVideoEntity>> getVideoInfoForUpload(
      String videoId) async {
    try {
      final Video video = await _youtubeApiDataSource.videos.get(videoId);

      final isAlreadyUploaded = await _youtubeRemoteDataSource
          .isYoutubeAlreadyUploaded(video.id.value);

      if (isAlreadyUploaded) {
        throw YtAlreadyUploadedException(video.id.value);
      }

      final responses = await Future.wait([
        _youtubeApiDataSource.channels.get(video.channelId),
        _youtubeApiDataSource.videos.closedCaptions.getManifest(videoId),
      ]);

      final channel = responses[0] as Channel;
      final caption = responses[1] as ClosedCaptionManifest;

      /// 자막이 없는 영상
      if (caption.tracks.isEmpty) {
        throw const YtNoCaptionException();
      }

      if (video.duration != null && video.duration!.inSeconds <= 60) {
        throw const YtNotEnoughContentDurationException();
      }

      final ClosedCaptionTrack tracks = await _youtubeApiDataSource
          .videos.closedCaptions
          .get(caption.tracks.first);

      final result = YoutubeVideoEntity.fromExplore(
        video: video,
        captions: tracks.captions.toList(),
        channel: channel,
      );
      return Result.success(result);
    } on YoutubeUploadException catch (e) {
      return Result.failure(e);
    } catch (e) {
      log('getYoutubeVideoData : $e');
      return Result.failure(
        const YtVideoInfoFetchedFailedException(),
      );
    }
  }

  @override
  Future<Result<void>> uploadYoutube({
    required YoutubeContentOverviewEntity contentMainInfo,
    required SummaryEntity summary,
    required Set<YoutubeQnaEntity> qnas,
    required String uploaderId,
    required String uploadLanguageCode,
  }) async {
    try {
      await _youtubeRemoteDataSource.uploadYoutube(
        channel: ChannelModel.fromEntity(contentMainInfo.channel),
        qnas: qnas.map((e) => YoutubeQnaModel.fromEntity(e)).toList(),
        mainInfo: contentMainInfo.toModel(
          uploaderId: uploaderId,
          uploadLanguageCode: uploadLanguageCode,
        ),
        summary: summary.toModel(),
      );

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnExceptedErrorException(e.toString()));
    }
  }

  @override
  Future<Result<YoutubeContentOverviewEntity>> getYoutubeMainInfo(
      {required String contentId}) async {
    try {
      final response = await _youtubeRemoteDataSource
          .getSingleYoutubeMainContent(contentId: contentId);
      final skills = response.relatedSkillIds
          .map(_techSetRepository.getSkillById)
          .toList();
      return Result.success(response.toEntity(skills));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
