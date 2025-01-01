import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_summary_response_entity.dart';

part 'summary_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: false)
class SummaryEntity {
  /// 핵심 요약
  final String mainTheme;

  /// 요약 노트
  final List<ParagraphEntity> summaries;

  const SummaryEntity({
    required this.mainTheme,
    required this.summaries,
  });

  SummaryModel toModel() => SummaryModel(
        mainTheme: mainTheme,
        summaries: summaries.map((summary) => summary.toModel()).toList(),
      );

  factory SummaryEntity.fromUploadResponse(YoutubeAiSummaryResponse response) {
    // gpt에서 전달해준 값이 가끔 정렬이 안맞는 경우가 있어 sort
    final sortedSummaries =
        List<ParagraphEntity>.from(response.summary.summaries)
          ..sort((a, b) {
            final aTimestamp = a.timestamp ?? const Duration(hours: 10);
            final bTimestamp = b.timestamp ?? const Duration(hours: 10);
            return aTimestamp.compareTo(bTimestamp);
          });

    return SummaryEntity(
      mainTheme: response.summary.mainTheme,
      summaries: sortedSummaries,
    );
  }

  /// JSON에서 모델로 변환
  factory SummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$SummaryEntityFromJson(json);

  factory SummaryEntity.unDefined() =>
      const SummaryEntity(mainTheme: '', summaries: []);
}
