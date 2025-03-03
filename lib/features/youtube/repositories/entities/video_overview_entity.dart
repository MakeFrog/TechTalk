import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class VideoOverviewEntity {
  final String id;
  final String thumbnailImgUrl;
  final String title;
  final String channelName;

  VideoOverviewEntity({
    required this.id,
    required this.title,
    required this.thumbnailImgUrl,
    required this.channelName,
  });

  factory VideoOverviewEntity.fromVideoExplore(Video video) =>
      VideoOverviewEntity(
        id: video.id.value,
        title: video.title,
        thumbnailImgUrl: video.thumbnails.highResUrl,
        channelName: video.author,
      );
}
