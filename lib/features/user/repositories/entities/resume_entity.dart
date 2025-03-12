import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

final class ResumeEntity extends DocumentBaseEntity {
  ResumeEntity({
    type = DocumentType.resume,
    super.path,
    super.title,
    super.uploadAt,
  });
}
