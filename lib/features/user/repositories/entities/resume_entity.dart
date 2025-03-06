import 'package:techtalk/features/user/repositories/entities/document_base_entity.dart';
import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

final class ResumeEntity extends DocumentBaseEntity {
  static DocumentType type = DocumentType.resume; // 문서 유형: 이력서

  ResumeEntity({
    super.path,
    super.title,
    super.uploadAt,
  });
}