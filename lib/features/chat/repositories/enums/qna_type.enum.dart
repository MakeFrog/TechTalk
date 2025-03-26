///
/// 문답 타입
///
enum QnaType {
  common, // 단골 면접 질문,
  resume, // 이력서(+포트폴리오) 면접 질문
  youtube, // 유튜브 콘텐츠 기발 면접 질문
  proficiency; // 역량별 면접

  bool get isCommon => this == QnaType.common;

  bool get isResume => this == QnaType.resume;

  bool get isYoutube => this == QnaType.youtube;

  R branch<R>({
    required R Function(QnaType type) common,
    required R Function(QnaType type) resume,
    required R Function(QnaType type) youtube,
    required R Function(QnaType type) proficiency,
  }) {
    switch (this) {
      case QnaType.common:
        return common(this);
      case QnaType.resume:
        return resume(this);
      case QnaType.youtube:
        return youtube(this);
      case QnaType.proficiency:
        return proficiency(this);

      default:
        throw Exception('잘못된 타입입니다 : $this');
    }
  }
}
