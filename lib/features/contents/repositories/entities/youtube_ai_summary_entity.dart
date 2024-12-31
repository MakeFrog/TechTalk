import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/youtube_content_analyzed_type.dart';

final class YoutubeAiSummaryEntity {
  /// 분석 타입
  final YoutubeContentAnalyzedType type;

  /// 요약
  final SummaryEntity summary;

  const YoutubeAiSummaryEntity({required this.type, required this.summary});

  factory YoutubeAiSummaryEntity.fromJson(Map<String, dynamic> json) {
    return YoutubeAiSummaryEntity(
      type: YoutubeContentAnalyzedType.getById(json['type']),
      summary: SummaryEntity.fromJson(json),
    );
  }
}
