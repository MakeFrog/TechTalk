import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

final class PortfolioEntity extends DocumentBaseEntity {
  static DocumentType type = DocumentType.portfolio; // 문서 유형: 포트폴리오

  PortfolioEntity({
    super.path,
    super.title,
    super.uploadAt,
  });
}
