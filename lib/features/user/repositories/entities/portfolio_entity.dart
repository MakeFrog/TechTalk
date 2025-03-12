import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

final class PortfolioEntity extends DocumentBaseEntity {
  PortfolioEntity({
    type = DocumentType.portfolio,
    super.path,
    super.title,
    super.uploadAt,
  });
}
