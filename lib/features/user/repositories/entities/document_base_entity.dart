abstract class DocumentBaseEntity {
  final String? path; // 문서 파일 경로
  final String? title; // 문서 제목
  final String? uploadAt; // 문서 업로드 시간
  final bool? isFileExist;

  DocumentBaseEntity({
    this.path,
    this.title,
    this.uploadAt,
    this.isFileExist,
  });
}
