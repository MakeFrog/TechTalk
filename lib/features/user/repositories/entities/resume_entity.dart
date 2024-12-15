import 'dart:io';

import 'package:techtalk/features/user/repositories/entities/base_document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/enum/document_type.dart';

class ResumeEntity extends BaseDocumentEntity {
  const ResumeEntity({
    required super.downloadUrl,
    required super.file,
    super.type = DocumentType.resume,
  });

  ResumeEntity copyWith({
    String? downloadUrl,
    File? file,
    DocumentType? type,
  }) {
    return ResumeEntity(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      file: file ?? this.file,
      type: type ?? this.type,
    );
  }
}
