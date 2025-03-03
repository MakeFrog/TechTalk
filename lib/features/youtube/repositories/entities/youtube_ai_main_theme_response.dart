import 'package:techtalk/features/youtube/repositories/enums/youtube_content_analyzed_type.dart';

final class YoutubeAiMainThemeResponse {
  /// 분석 타입
  final YoutubeContentAnalyzedType type;

  /// 핵심 요약
  final String mainTheme;

  YoutubeAiMainThemeResponse({
    required this.type,
    required this.mainTheme,
  });

  YoutubeAiMainThemeResponse copyWith({
    YoutubeContentAnalyzedType? type,
    String? mainTheme,
  }) {
    return YoutubeAiMainThemeResponse(
      type: type ?? this.type,
      mainTheme: mainTheme ?? this.mainTheme,
    );
  }

  factory YoutubeAiMainThemeResponse.fromJson(Map<String, dynamic> json) {
    return YoutubeAiMainThemeResponse(
      type: YoutubeContentAnalyzedType.getById(json['type']),
      mainTheme: json['main_theme'],
    );
  }
}
