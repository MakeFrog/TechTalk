import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';

part 'related_youtube_videos_provider.g.dart';

@riverpod
class RelatedYoutubeVideo extends _$RelatedYoutubeVideo {
  @override
  FutureOr<List<VideoOverviewEntity>> build(String contentId) async {
    final response = await youtubeRepository.getRelatedVideo(contentId);
    return response.fold(
      onSuccess: (videos) {
        return videos;
      },
      onFailure: (e) {
        log('유튜브 관련 정보 호출 실패 : ${e}');
        throw e;
      },
    );
  }
}
