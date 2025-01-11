import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_related_vido_entity.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///
/// [YoutubeExplode]의
/// [Video] / [Channel] / [ClosedCaptionManifest] 속성으로 매핑되는 entity
/// 현재는 [Upload] 섹션에서만 사용되는 프로퍼티만 매핑되어 있음.
///
class YoutubeVideoEntity {
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
  final DateTime? publishedDate;

  /// Duration of the video.
  final Duration? duration;

  /// Available thumbnails for this video.
  final ThumbnailSet thumbnails;

  /// 자막 리스트
  final List<CaptionEntity> captions;

  /// 전체 스크립(본문)
  final String script;

  /// 채널 정보
  final ChannelEntity channel;

  YoutubeVideoEntity({
    required this.id,
    required this.title,
    required this.channelName,
    required this.channelId,
    required this.publishedDate,
    required this.duration,
    required this.thumbnails,
    required this.captions,
    required this.script,
    required this.channel,
  });

  factory YoutubeVideoEntity.fromExplore({
    required Video video,
    required List<ClosedCaption> captions,
    required Channel channel,
  }) {
    final List<CaptionEntity> targetCaptions = [];
    String totalScript = '';

    for (var e in captions) {
      targetCaptions.add(CaptionEntity.fromExplore(e));
      totalScript += ' ${e.text}';
    }

    return YoutubeVideoEntity(
      id: video.id.value,
      title: video.title,
      channelName: video.author,
      channelId: video.channelId.value,
      publishedDate: video.publishDate,
      duration: video.duration,
      thumbnails: video.thumbnails,
      captions: targetCaptions,
      script: totalScript,
      channel: ChannelEntity(
        id: channel.id.value,
        name: channel.title,
        logoUrl: channel.logoUrl,
      ),
    );
  }

  factory YoutubeVideoEntity.fromRelatedVideoEntity(
    RelatedVideoEntity entity,
  ) {
    return YoutubeVideoEntity(
      id: entity.id,
      title: entity.title,
      channelName: entity.channelName,
      channelId: '',
      duration: Duration.zero,
      thumbnails: ThumbnailSet(entity.id),
      captions: [],
      script: '',
      publishedDate: null,
      channel: ChannelEntity.undefined(),
    );
  }

  YoutubeVideoEntity copyWith({
    String? id,
    String? title,
    String? channelName,
    String? channelId,
    String? description,
    DateTime? uploadDate,
    Duration? duration,
    ThumbnailSet? thumbnails,
    List<CaptionEntity>? captions,
    String? script,
    ChannelEntity? channel,
  }) {
    return YoutubeVideoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      channelName: channelName ?? this.channelName,
      channelId: channelId ?? this.channelId,
      publishedDate: uploadDate ?? this.publishedDate,
      duration: duration ?? this.duration,
      thumbnails: thumbnails ?? this.thumbnails,
      captions: captions ?? this.captions,
      script: script ?? this.script,
      channel: channel ?? this.channel,
    );
  }
}
