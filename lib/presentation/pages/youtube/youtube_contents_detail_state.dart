import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/presentation/pages/youtube/providers/youtube_contents_detail_data_provider.dart';
import 'package:techtalk/presentation/pages/youtube/providers/youtube_video_data_provider.dart';

mixin class YoutubeContentsDetailState {
  ///
  /// 유튜브 api에서 불러오는 비디오 관련 데이터
  ///
  AsyncValue<YouTubeVideoDataEntity> youtubeVideoDataAsync(WidgetRef ref, String contentsId) =>
      ref.watch(youtubeVideoDataProvider(contentsId));

  ///
  /// 테크톡 DB에서 불러오는 해당 비디오 컨텐츠 데이터
  ///
  AsyncValue<YoutubeContentsDetailEntity> youtubeContentsDetailDataAsync(WidgetRef ref, String contentsId) =>
      ref.watch(youtubeContentsDetailDataProvider(contentsId));
}
