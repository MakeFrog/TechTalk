part of 'youtube_repository_impl.dart';

/* Top level 호출문 / [getRelatedVideo]에서 사용됨 */
Future<List<Video>?> _fetchRelatedVideos(Video video) async {
  final relatedVideosList =
      await AppYoutubeExplode.getInstance().videos.getRelatedVideos(video);

  return relatedVideosList?.toList();
}

Future<Video> _fetchVideo(String contentId) async {
  final response = await AppYoutubeExplode.getInstance().videos.get(contentId);
  return response;
}

Future<Channel> _fetchChannel(String contentId) async {
  // _youtubeApiDataSource.channels.get(video.channelId),
  final response =
      await AppYoutubeExplode.getInstance().channels.get(contentId);
  return response;
}

Future<ClosedCaptionManifest> _fetchCaptionManifest(String contentId) async {
  final response = await AppYoutubeExplode.getInstance()
      .videos
      .closedCaptions
      .getManifest(contentId);

  return response;
}

Future<ClosedCaptionTrack> _fetchCaptionTrack(
    {required ClosedCaptionTrackInfo trackInfo}) async {
  final response = await AppYoutubeExplode.getInstance()
      .videos
      .closedCaptions
      .get(trackInfo);
  return response;
}
