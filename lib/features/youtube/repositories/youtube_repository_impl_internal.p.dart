part of 'youtube_repository_impl.dart';

/* Top level 호출문 / [getRelatedVideo]에서 사용됨 */
Future<List<Video>?> _fetchRelatedVideos(Video video) async {
  final youtube = YoutubeExplode(); // YoutubeExplode 인스턴스 생성
  final relatedVideosList = await youtube.videos.getRelatedVideos(video);

  return relatedVideosList?.toList();
}

Future<Video> _fetchVideo(String contentId) async {
  final youtube = YoutubeExplode(); // YoutubeExplode 인스턴스 생성
  return youtube.videos.get(contentId); // 비디오 객체 반환
}
