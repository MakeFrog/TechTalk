import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///
/// [YoutubeExplode]의
/// [ClosedCaption]속성으로 매핑되는 entity
/// 현재는 [Upload] 섹션에서만 사용되는 프로퍼티만 매핑되어 있음.
///
final class CaptionEntity {
  /// Text displayed by this caption.
  final String text;

  /// Time at which this caption starts being displayed.
  final Duration offset;

  /// Duration this caption is displayed.
  final Duration duration;

  /// Time at which this caption ends being displayed.
  Duration get end => offset + duration;

  CaptionEntity({
    required this.text,
    required this.offset,
    required this.duration,
  });

  factory CaptionEntity.fromExplore(ClosedCaption caption) {
    return CaptionEntity(
      text: caption.text,
      offset: caption.offset,
      duration: caption.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'offset': this.offset,
      'duration': this.duration,
    };
  }

  factory CaptionEntity.fromMap(Map<String, dynamic> map) {
    return CaptionEntity(
      text: map['text'] as String,
      offset: map['offset'] as Duration,
      duration: map['duration'] as Duration,
    );
  }
}
