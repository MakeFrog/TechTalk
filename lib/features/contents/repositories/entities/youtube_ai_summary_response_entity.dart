import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/youtube_content_analyzed_type.dart';

final class YoutubeAiSummaryResponse {
  /// 분석 타입
  final YoutubeContentAnalyzedType type;

  /// 요약
  final SummaryEntity summary;

  const YoutubeAiSummaryResponse({required this.type, required this.summary});

  factory YoutubeAiSummaryResponse.fromJson(Map<String, dynamic> json) {
    return YoutubeAiSummaryResponse(
      type: YoutubeContentAnalyzedType.getById(json['type']),
      summary: SummaryEntity.fromJson(json),
    );
  }
}
