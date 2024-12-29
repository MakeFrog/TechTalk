import 'package:techtalk/features/contents/repositories/entities/caption_entity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///
/// [YoutubeExplode]의
/// [Video]속성으로 매핑되는 entity
/// 현재는 [Upload] 섹션에서만 사용되는 프로퍼티만 매핑되어 있음.
///
class YoutubeVideoAndCaptionEntity {
  /// Video ID.
  final String id;

  /// Video title.
  final String title;

  /// Video author.
  final String channelName;

  /// Video author Id.
  final String channelId;

  /// Video upload date.
  /// Note: For search queries it is calculated with:
  ///   DateTime.now() - how much time is was published.
  final DateTime? uploadDate;

  /// Duration of the video.
  final Duration? duration;

  /// Available thumbnails for this video.
  final ThumbnailSet thumbnails;

  final List<CaptionEntity> captions;

  final String script;

  YoutubeVideoAndCaptionEntity({
    required this.id,
    required this.title,
    required this.channelName,
    required this.channelId,
    required this.uploadDate,
    required this.duration,
    required this.thumbnails,
    required this.captions,
    required this.script,
  });

  factory YoutubeVideoAndCaptionEntity.fromExplore(
      {required Video video, required List<ClosedCaption> captions}) {
    final List<CaptionEntity> targetCaptions = [];
    String totalScript = '';

    for (var e in captions) {
      targetCaptions.add(CaptionEntity.fromExplore(e));
      totalScript += ' ${e.text}';
    }

    return YoutubeVideoAndCaptionEntity(
      id: video.id.value,
      title: video.title,
      channelName: video.author,
      channelId: video.channelId.value,
      uploadDate: video.uploadDate,
      duration: video.duration,
      thumbnails: video.thumbnails,
      captions: targetCaptions,
      script: totalScript,
    );
  }
}
