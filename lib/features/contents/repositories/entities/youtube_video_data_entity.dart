import 'package:techtalk/app/localization/localization_enum.dart';
import 'package:techtalk/core/helper/int_extension.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// YouTube API에서 가져온 비디오 데이터
class YouTubeVideoDataEntity {
  final String id;
  final String url;
  final String title;
  final ThumbnailSet thumnailSet;
  final Engagement engagement;
  final Channel channelInfo;
  final Duration? duration;
  final DateTime? uploadDate;

  YouTubeVideoDataEntity({
    required this.id,
    required this.url,
    required this.title,
    required this.thumnailSet,
    required this.engagement,
    required this.channelInfo,
    this.duration,
    this.uploadDate,
  });

  String get viewCountStr => engagement.viewCount.formatViewCount(Localization.kr);

  String get likeCountStr => (engagement.likeCount ?? 0).formatCount(Localization.kr);
}
