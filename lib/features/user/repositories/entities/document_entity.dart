import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';

final class DocumentEntity {
  final ResumeEntity resume;
  final PortfolioEntity portfolio;

  const DocumentEntity({
    required this.resume,
    required this.portfolio,
  });

  /// 각 필드를 변경할 수 있도록 copyWith를 제공
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
