import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class YoutubeContentsRepository {
  ///
  /// 유튜브 api를 통해 동영상 관련 데이터 가져오기
  ///
  Future<Result<YouTubeVideoDataEntity>> getYoutubeVideoData(
    String videoId,
  );

  ///
  /// 유튜브 컨텐츠 상세 정보 가져오기
  ///
  Future<Result<YoutubeContentsDetailEntity>> getYoutubeContentsDetail(
    String videoId,
  );

  ///
  /// 유튜브 컨텐츠 관련 질문 가져오기
  ///
  Future<Result<List<QnaEntity>>> getYoutubeContentsDetailQnas(
    String videoId,
  );
}
