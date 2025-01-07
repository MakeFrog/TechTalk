///
/// 문답 타입
///
enum QnaType {
  common, // 단골 면접 질문,
  resume, // 이력서(+포트폴리오) 면접 질문
  youtube; // 유튜브 콘텐츠 기발 면접 질문

  bool get isCommon => this == QnaType.common;
  bool get isResume => this == QnaType.resume;
  bool get isYoutube => this == QnaType.youtube;
}
