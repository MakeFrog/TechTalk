import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// YouTube API에서 가져온 비디오 데이터
class YouTubeVideoDataEntity {
  final String videoId;
  final String videoUrl;
  final String videoTitle;
  final Engagement engagement;
  final Channel channelInfo;
  final Duration? duration;
  final DateTime? uploadDate;

  YouTubeVideoDataEntity({
    required this.videoId,
    required this.videoUrl,
    required this.videoTitle,
    required this.engagement,
    required this.channelInfo,
    this.duration,
    this.uploadDate,
  });
}
