import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class YoutubeContentsRemoteDataSource {
  ///
  /// 유튜브 영상 컨텐츠 디테일
  ///
  Future<YoutubeContentsDetailModel> getYoutubeContentsDetail(String contentsId);

  ///
  /// 유튜브 영상 관련 질문
  ///
  Future<List<TopicQnaModel>> getYoutubeContentsDetailQnas(String contentsId);
}
