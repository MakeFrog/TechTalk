import 'package:techtalk/features/user/repositories/enums/document_type.enum.dart';

abstract class DocumentBaseEntity {
  final DocumentType? type; // 문서 타입 (이력서/포트폴리오)
  final String? path; // 문서 파일 경로
  final String? title; // 문서 제목
  final String? uploadAt; // 문서 업로드 시간

  DocumentBaseEntity({
    this.type,
    this.path,
    this.title,
    this.uploadAt,
  });
}
