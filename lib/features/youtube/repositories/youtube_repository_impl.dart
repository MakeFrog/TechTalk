// youtube_repository_impl.dart

import 'dart:developer';
import 'dart:isolate';
import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_isolate_mixin/easy_isolate_mixin.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/app/network/app_youtube_explode.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/firebase_query_constraints.dart';
import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/tech_set/repositories/tech_set_repository.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/channel_detail_entity.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';
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

  /// Isolate에서 실행될 이미지 프리캐시 작업
  static Future<void> _isolateImagePrecache(List<String> imageUrls) async {
    final client = HttpClient();
    try {
      await Future.wait(
        imageUrls.map((url) async {
          try {
            final uri = Uri.parse(url);
            final request = await client.getUrl(uri);
            final response = await request.close();
            await response.drain<void>(); // 데이터를 읽어서 버퍼에 저장
          } catch (e) {
            debugPrint('이미지 다운로드 실패 (Isolate): $url - $e');
          }
        }),
      );
    } finally {
      client.close();
    }
  }

  /// 이미지 프리캐시 처리
  Future<void> _precacheImages(List<YoutubeMainModel> models) async {
    try {
      final imageUrls = models
          .where((model) => model.thumbnailImgUrl.isNotEmpty)
          .map((model) => model.thumbnailImgUrl)
          .toList();

      if (imageUrls.isEmpty) return;

      // Isolate 생성 및 실행
      final receivePort = ReceivePort();
      await Isolate.spawn(
        (List<String> urls) async {
          await _isolateImagePrecache(urls);
          Isolate.exit();
        },
        imageUrls,
      );

      // Isolate 완료 대기
      await receivePort.first;

      // UI 컨텍스트에서 실제 precacheImage 실행
      final context = await navigationContext;
      for (final url in imageUrls) {
        precacheImage(NetworkImage(url), context);
      }
    } catch (e) {
      debugPrint('이미지 프리캐시 실패: $e');
    }
  }

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
  Future<Result<FirebasePaginatedResult<YoutubeMainEntity, YoutubeMainModel>>>
      getRandomPagedYoutubeMainContents({
    required int limit,
    required String orderByField,
    DocumentSnapshot<YoutubeMainModel>? lastDocument,
    List<FirestoreQueryConstraint>? queryConstraints,
    required bool hasReversedQueryCallProceeded,
    required double random,
    required String randomKey,
  }) async {
    try {
      // Remote DataSource에서 페이징된 데이터 가져오기
      final remotePaginatedResult =
          await _youtubeRemoteDataSource.getRandomPagedYoutubeMainContents(
        limit: limit,
        orderByField: orderByField,
        lastDocument: lastDocument,
        queryConstraints: queryConstraints,
        hasReversedQueryCallProceeded: hasReversedQueryCallProceeded,
        random: random,
        randomKey: randomKey,
      );

      // 이미지 프리캐시를 백그라운드에서 실행
      unawaited(_precacheImages(remotePaginatedResult.items));

      final context = await navigationContext;

      // 모델을 엔티티로 변환
      final entities = remotePaginatedResult.items.map((model) {
        final skills =
            model.relatedSkillIds.map(_techSetRepository.getSkillById).toList();
        final jobGroups = model.relatedJobGroupIds
            .map(_techSetRepository.getJobGroupById)
            .toList();
        return model.toEntity(skills, jobGroups);
      }).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, YoutubeMainModel>(
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
        throw YtAlreadyUploadedException(video: video);
      }

      final responses = await Future.wait([
        /// [NOTE]
        /// channel 정보는 isolate 적용이 제한됨
        // _youtubeApiDataSource.channels.get(video.channelId),
        loadWithIsolate(() => _fetchChannel(video.channelId.value)),
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
    required YoutubeMainEntity contentMainInfo,
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
  Future<Result<YoutubeMainEntity>> getYoutubeMainInfo(
      {required String contentId}) async {
    try {
      final response = await _youtubeRemoteDataSource
          .getSingleYoutubeMainContent(contentId: contentId);
      final skills = response.relatedSkillIds
          .map(_techSetRepository.getSkillById)
          .toList();
      final jobGroups = response.relatedJobGroupIds
          .map(_techSetRepository.getJobGroupById)
          .toList();
      return Result.success(response.toEntity(skills, jobGroups));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<VideoOverviewEntity>>> getRelatedVideo(
      String contentId) async {
    try {
      // Top-level 함수로 contentId를 이용해 비디오를 가져옴
      final video = await loadWithIsolate(() => _fetchVideo(contentId));

      // Top-level 함수로 관련 비디오 리스트를 가져옴
      final relatedVideos =
          await loadWithIsolate(() => _fetchRelatedVideos(video));

      if (relatedVideos?.isEmpty ?? true) {
        return Result.success([]);
      }

      final context = await navigationContext;

      final result = relatedVideos!.map((e) {
        precacheImage(NetworkImage(e.thumbnails.highResUrl), context);
        return VideoOverviewEntity.fromVideoExplore(e);
      }).toList();
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

  @override
  Future<Result<FirebasePaginatedResult<YoutubeMainEntity, YoutubeMainModel>>>
      getPagedYoutubeMainContents(
          {required int limit,
          required String orderByField,
          DocumentSnapshot<YoutubeMainModel>? lastDocument,
          required bool fetchChannel,
          List<FirestoreQueryConstraint>? queryConstraints}) async {
    try {
      // Remote DataSource에서 페이징된 데이터 가져오기
      final remotePaginatedResult =
          await _youtubeRemoteDataSource.getPagedYoutubeMainContents(
        limit: limit,
        orderByField: orderByField,
        fetchChannel: fetchChannel,
        lastDocument: lastDocument,
        queryConstraints: queryConstraints,
      );

      // 모델을 엔티티로 변환
      final entities = remotePaginatedResult.items.map((model) {
        final skills =
            model.relatedSkillIds.map(_techSetRepository.getSkillById).toList();
        final jobGroups = model.relatedJobGroupIds
            .map(_techSetRepository.getJobGroupById)
            .toList();
        return model.toEntity(skills, jobGroups);
      }).toList();

      // 엔티티로 페이징된 결과 생성
      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, YoutubeMainModel>(
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
  Future<Result<ChannelDetailEntity>> getChannelDetail(String channelId) async {
    try {
      final response = await _youtubeApiDataSource.channels.get(channelId);

      final result = ChannelDetailEntity.fromExplore(response);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception('$this> $e'));
    }
  }

  @override
  Future<Result<void>> deleteContent({required String contentId}) async {
    try {
      await _youtubeRemoteDataSource.deleteContent(contentId: contentId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('this > $e'));
    }
  }
}
