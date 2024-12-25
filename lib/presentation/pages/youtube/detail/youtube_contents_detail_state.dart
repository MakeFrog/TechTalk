import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_contents_detail_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_contents_detail_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_video_data_provider.dart';

mixin class YoutubeContentsDetailState {
  ///
  /// 유튜브 api에서 불러오는 비디오 관련 데이터
  ///
  AsyncValue<YouTubeVideoDataEntity> youtubeVideoDataAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeVideoDataProvider(contentsId));

  ///
  /// 테크톡 DB에서 불러오는 해당 비디오 컨텐츠 데이터
  ///
  AsyncValue<YoutubeContentsDetailEntity> youtubeContentsDetailAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeContentsDetailProvider(contentsId));

  ///
  /// 테크톡 DB에서 불러오는 해당 비디오 컨텐츠 데이터
  ///
  AsyncValue<List<YoutubeQnaEntity>> youtubeContentsDetailQnasAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeContentsDetailQnasProvider(contentsId));
}
