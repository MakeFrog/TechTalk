import 'dart:io';

import 'package:techtalk/features/user/repositories/entities/base_document_entity.dart';
import 'package:techtalk/features/user/repositories/entities/enum/document_type.dart';

class PortfolioEntity extends BaseDocumentEntity {
  const PortfolioEntity({
    required super.downloadUrl,
    required super.file,
    super.type = DocumentType.resume,
  });

  PortfolioEntity copyWith({
    String? downloadUrl,
    File? file,
    DocumentType? type,
  }) {
    return PortfolioEntity(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      file: file ?? this.file,
      type: type ?? this.type,
    );
  }
}
