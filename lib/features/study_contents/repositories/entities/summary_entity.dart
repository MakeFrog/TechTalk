import 'package:techtalk/features/study_contents/repositories/entities/paragraph_entity.dart';

/// 요약 엔티티
class SummaryEntity {
  /// 핵심 요약
  final ParagraphEntity mainParagraph;

  /// 기타 요약
  final List<ParagraphEntity> additionalParagraph;

  SummaryEntity({
    required this.mainParagraph,
    required this.additionalParagraph,
  });
}
