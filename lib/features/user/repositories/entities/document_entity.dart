import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';

final class DocumentEntity {
  final ResumeEntity? resume;
  final PortfolioEntity? portfolio;
  bool isFileChanged; // 파일을 새로 업로드하거나 기존 파일을 삭제한 경우
  bool shouldShowTooltip; // 툴팁 표시 여부

  DocumentEntity({
    required this.resume,
    required this.portfolio,
    this.isFileChanged = false,
    this.shouldShowTooltip = false,
  });

  bool get hasFetchedAnyDocuments => resume != null || portfolio != null;

  DocumentEntity copyWith({
    ResumeEntity? resume,
    PortfolioEntity? portfolio,
    bool? isFileChanged,
    bool? shouldShowTooltip,
  }) {
    return DocumentEntity(
      resume: resume ?? this.resume,
      portfolio: portfolio ?? this.portfolio,
      isFileChanged: isFileChanged ?? this.isFileChanged,
      shouldShowTooltip: shouldShowTooltip ?? this.shouldShowTooltip,
    );
  }

  DocumentEntity deleteResume() {
    return DocumentEntity(
      resume: null,
      portfolio: portfolio,
      isFileChanged: true,
    );
  }

  DocumentEntity deletePortfolio() {
    return DocumentEntity(
      resume: resume,
      portfolio: null,
      isFileChanged: true,
    );
  }
}
