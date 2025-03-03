import 'package:techtalk/features/youtube/index.dart';

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

  YoutubeAiSummaryResponse copyWith({
    YoutubeContentAnalyzedType? type,
    SummaryEntity? summary,
  }) {
    return YoutubeAiSummaryResponse(
      type: type ?? this.type,
      summary: summary ?? this.summary,
    );
  }
}
