import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class RelatedVideoEntity {
  final String id;
  final String thumbnailImgUrl;
  final String title;
  final String channelName;

  RelatedVideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailImgUrl,
    required this.channelName,
  });

  factory RelatedVideoEntity.fromVideoExplore(Video video) =>
      RelatedVideoEntity(
        id: video.id.value,
        title: video.title,
        thumbnailImgUrl: video.thumbnails.highResUrl,
        channelName: video.author,
      );
}
