import 'dart:io';

import 'package:techtalk/features/user/repositories/entities/enum/document_type.dart';

abstract class BaseDocumentEntity {
  final String? downloadUrl;
  final File? file;
  final DocumentType type;

  const BaseDocumentEntity({
    required this.downloadUrl,
    required this.file,
    required this.type,
  });

  /// 원격에 등록되어 있는지 여부
  bool get hasRemoteUploaded => downloadUrl != null;

  /// 문서가 존재하는지 여부
  bool get hasDocumentFile => file != null;

  /// 문서 타입 비교
  bool get isResume => type.isResume;
  bool get isPortfolio => type.isPortfolio;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseDocumentEntity &&
          runtimeType == other.runtimeType &&
          downloadUrl == other.downloadUrl &&
          file == other.file &&
          type == other.type;

  @override
  int get hashCode => downloadUrl.hashCode ^ file.hashCode ^ type.hashCode;
}
