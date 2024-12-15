///
/// 문서(이력서, 포트폴리오) 타입
///
enum DocumentType {
  resume('이력서'),
  portfolio('포트폴리오');

  final String label;

  const DocumentType(this.label);

  bool get isResume => DocumentType.resume == this;

  bool get isPortfolio => DocumentType.portfolio == this;
}
