import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';

abstract interface class YoutubeContentsRepository {
  ///
  /// 유튜브 api를 통해 동영상 관련 데이터 가져오기
  ///
  Future<Result<YouTubeVideoDataEntity>> getYoutubeVideoData(
    String videoId,
  );
}
