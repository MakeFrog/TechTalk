import 'package:techtalk/features/contents/data_source/remote/models/youtube_contents_detail_model.dart';

abstract interface class YoutubeContentsRemoteDataSource {
  ///
  /// 유튜브 영상 컨텐츠 디테일
  ///
  Future<YoutubeContentsDetailModel> getYoutubeContentsDetail(String contentsId);
}
