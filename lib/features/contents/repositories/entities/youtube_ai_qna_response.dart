import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/youtube_content_analyzed_type.dart';

final class YoutubeAiQnaResponse {
  /// 분석 타입
  final YoutubeContentAnalyzedType type;

  /// 모범답변
  final List<YoutubeQnaEntity> qnas;

  YoutubeAiQnaResponse({required this.type, required this.qnas});

  factory YoutubeAiQnaResponse.fromJson(Map<String, dynamic> json) {
    return YoutubeAiQnaResponse(
      type: YoutubeContentAnalyzedType.getById(json['type']),
      qnas: (json['qnas'] as List<dynamic>)
          .map((e) => YoutubeQnaEntity.fromJson(e))
          .toList(),
    );
  }
}
