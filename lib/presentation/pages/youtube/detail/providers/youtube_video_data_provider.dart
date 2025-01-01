import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/contents/index.dart';

part 'youtube_video_data_provider.g.dart';

@riverpod
class YoutubeVideoData extends _$YoutubeVideoData {
  @override
  Future<YouTubeVideoDataEntity> build(String videoId) async {
    final result = await getYoutubeVideoDataUseCase.call(videoId);
    return result.fold(
      onSuccess: (data) => data,
      onFailure: (e) {
        log(e.toString());
        throw e;
      },
    );
  }
}
