// youtube_repository_impl.dart

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_isolate_mixin/easy_isolate_mixin.dart';
import 'package:techtalk/app/network/app_youtube_explode.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_related_vido_entity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'youtube_repository_impl_internal.p.dart';

class YoutubeRepositoryImpl
    with IsolateHelperMixin
    implements YoutubeRepository {
  YoutubeRepositoryImpl(this._youtubeApiDataSource,
      this._youtubeRemoteDataSource, this._techSetRepository);

  final YoutubeExplode _youtubeApiDataSource;
  final YoutubeRemoteDataSource _youtubeRemoteDataSource;
  final TechSetRepository _techSetRepository;

  @override
  Future<Result<YoutubeCoreVideoEntity>> getYoutubeVideoData(
      String videoId) async {
    try {
      final Video video = await _youtubeApiDataSource.videos.get(videoId);
      final Channel channel =
          await _youtubeApiDataSource.channels.get(video.channelId);

      return Result.success(
        YoutubeCoreVideoEntity(
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
  Future<
      Result<
          FirebasePaginatedResult<YoutubeContentOverviewEntity,
              YoutubeMainModel>>> getPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
    required bool hasReversedQueryCallProceeded,
    required double random,
  }) async {
    try {
      // Remote DataSource에서 페이징된 데이터 가져오기
      final remotePaginatedResult =
          await _youtubeRemoteDataSource.getPagedYoutubeMainContents(
        limit: limit,
        orderByField: orderByField,
        lastDocument: lastDocument,
        queryConstraints: queryConstraints,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        random: random,
      );

      // 모델을 엔티티로 변환
      final entities = remotePaginatedResult.items.map((model) {
        final skills =
            model.relatedSkillIds.map(_techSetRepository.getSkillById).toList();
        return model.toEntity(skills);
      }).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult = FirebasePaginatedResult<
          YoutubeContentOverviewEntity, YoutubeMainModel>(
        items: entities,
        lastDocument: remotePaginatedResult.lastDocument,
        hasMore: remotePaginatedResult.hasMore,
        hasReversedQueryCallProceeded:
            remotePaginatedResult.hasReversedQueryCallProceeded,
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
      final Video video = await _fetchVideo(videoId);

      final isAlreadyUploaded = await _youtubeRemoteDataSource
          .isYoutubeAlreadyUploaded(video.id.value);

      if (isAlreadyUploaded) {
        throw YtAlreadyUploadedException(video.id.value);
      }

      final responses = await Future.wait([
        /// [NOTE]
        /// channel 정보는 isolate 적용이 제한됨
        _youtubeApiDataSource.channels.get(video.channelId),
        loadWithIsolate(() => _fetchCaptionManifest(videoId)),
      ]);

      final channel = responses[0] as Channel;
      final manifest = responses[1] as ClosedCaptionManifest;

      /// 자막이 없는 영상
      if (manifest.tracks.isEmpty) {
        throw const YtNoCaptionException();
      }

      if (video.duration != null && video.duration!.inSeconds <= 60) {
        throw const YtNotEnoughContentDurationException();
      }

      final ClosedCaptionTrack tracks = await loadWithIsolate(
          () => _fetchCaptionTrack(trackInfo: manifest.tracks.first));

      final result = YoutubeVideoEntity.fromExplore(
        video: video,
        captions: tracks.captions.toList(),
        channel: channel,
      );

      return Result.success(result);
    } catch (e) {
      log('getYoutubeVideoData : $e');
      if (e is YoutubeUploadException) {
        return Result.failure(e);
      }

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
        uploaderId: uploaderId,
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

  @override
  Future<Result<List<RelatedVideoEntity>>> getRelatedVideo(
      String contentId) async {
    print('콘텐츠 아이디 : ${contentId}');
    try {
      // Top-level 함수로 contentId를 이용해 비디오를 가져옴
      final video = await loadWithIsolate(() => _fetchVideo(contentId));

      // Top-level 함수로 관련 비디오 리스트를 가져옴
      final relatedVideos =
          await loadWithIsolate(() => _fetchRelatedVideos(video));

      if (relatedVideos?.isEmpty ?? true) {
        return Result.success([]);
      }

      final result = relatedVideos!
          .map((e) => RelatedVideoEntity.fromVideoExplore(e))
          .toList();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<String>> getScript({required String videoId}) async {
    try {
      final manifest =
          await loadWithIsolate(() => _fetchCaptionManifest(videoId));

      /// 자막이 없는 영상
      if (manifest.tracks.isEmpty) {
        throw const YtNoCaptionException();
      }

      final caption = await loadWithIsolate(
          () => _fetchCaptionTrack(trackInfo: manifest.tracks.first));

      String script = '';

      for (var e in caption.captions) {
        script += ' ${e.text}';
      }

      /// 자막이 없는 영상
      if (script.isEmpty) {
        throw const YtNoCaptionException();
      }

      return Result.success(script);
    } catch (e) {
      log('getCaption >$e');
      return Result.failure(const YtUnknownException());
    }
  }

  @override
  Future<Result<bool>> isUploadedContent({required String videoId}) async {
    try {
      final isAlreadyUploaded =
          await _youtubeRemoteDataSource.isYoutubeAlreadyUploaded(videoId);

      return Result.success(isAlreadyUploaded);
    } catch (e) {
      return Result.failure(
          Exception('Youtube Repository > isUploadedContent : $e'));
    }
  }
}
