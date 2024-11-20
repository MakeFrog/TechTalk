import 'package:techtalk/features/contents/data_source/remote/models/summary_model.dart';
import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';

/// 요약 엔티티
class SummaryEntity {
  /// 핵심 요약
  final List<String> mainTheme;

  /// 요약 노트
  final List<ParagraphEntity> summaryNotes;

  SummaryEntity({
    required this.mainTheme,
    required this.summaryNotes,
  });

  SummaryModel toModel() => SummaryModel(
        mainTheme: mainTheme,
        summaries: summaryNotes.map((summary) => summary.toModel()).toList(),
      );
}
