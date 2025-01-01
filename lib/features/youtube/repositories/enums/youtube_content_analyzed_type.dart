///
/// 유튜브 분석 prompt 타입을 나타날 떄 사용하는 enum
/// (요약 / 면접 질문 생성 / 스킬,직군 키워드 매칭)
///
enum YoutubeContentAnalyzedType {
  isValid, // 유효한 콘텐츠
  notTech, // 개발 콘텐츠가 아님
  lackOfContent, // 개발 관련 콘텐츠더라도 요약, 질문 생성을하기에는 부족
  undefined; // 정의가 안된 타입

  static YoutubeContentAnalyzedType getById(String id) {
    return YoutubeContentAnalyzedType.values.firstWhere(
      (e) {
        final safeElement = e.name.toLowerCase();
        final safeId = id.toLowerCase();

        return safeElement == safeId;
      },
      orElse: () => YoutubeContentAnalyzedType.undefined,
    );
  }

  bool get isValidContent => this == YoutubeContentAnalyzedType.isValid;

  bool get isInvalid => !(this == YoutubeContentAnalyzedType.isValid);
}
