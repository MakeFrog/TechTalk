import 'dart:developer';

import 'package:techtalk/core/modules/error_handling/result.dart';
import 'package:techtalk/core/modules/exceptions/custom_exception.dart';
import 'package:techtalk/features/contents/repositories/contents_repository.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ContentsRepositoryImpl implements ContentsRepository {
  @override
  Future<Result<YouTubeVideoDataEntity>> getYoutubeVideoData(String videoId) async {
    try {
      final ys = YoutubeExplode();
      final video = await ys.videos.get(videoId);
      final channel = await ys.channels.get(video.channelId);

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
}
