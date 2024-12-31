import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';

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

  /// JSON에서 모델로 변환
  factory SummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$SummaryEntityFromJson(json);

  factory SummaryEntity.unDefined() =>
      const SummaryEntity(mainTheme: '', summaries: []);
}
