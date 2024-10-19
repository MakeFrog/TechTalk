/// 한 문단을 구성하는 엔티티
class ParagraphEntity {
  /// 문단 제목
  final String title;

  /// 문단 내용
  final String contents;

  ParagraphEntity({
    required this.title,
    required this.contents,
  });
}
