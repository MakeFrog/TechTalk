import 'dart:developer';

import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';
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
}
