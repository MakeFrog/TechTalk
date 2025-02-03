import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';

final class DocumentEntity {
  final ResumeEntity? resume;
  final PortfolioEntity? portfolio;

  const DocumentEntity({
    required this.resume,
    required this.portfolio,
  });

  bool get hasFetchedAnyDocuments => resume != null || portfolio != null;

  DocumentEntity copyWith({
    ResumeEntity? resume,
    PortfolioEntity? portfolio,
  }) {
    return DocumentEntity(
      resume: resume ?? this.resume,
      portfolio: portfolio ?? this.portfolio,
    );
  }
}
