import 'package:techtalk/features/contents/repositories/entities/paragraph_entity.dart';

/// 요약 엔티티
class SummaryEntity {
  /// 핵심 요약
  final ParagraphEntity mainSummary;

  /// 요약 노트
  final List<ParagraphEntity> additionalSummary;

  SummaryEntity({
    required this.mainSummary,
    required this.additionalSummary,
  });
}
