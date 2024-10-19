/// 컨텐츠의 오버뷰 정보, 리스트 같은 곳에서 보기 위함
abstract interface class ContentsOverviewEntity {
  /// 아이디
  final String id;

  /// 컨텐츠 아이디
  final String contentsId;

  /// 컨텐츠 썸네일 이미지 url
  final String thumbnailImgUrl;

  /// 컨텐츠 타이틀
  final String contentsTitle;

  /// 컨텐츠에서 생성된 질문 개수 - gpt로 돌리지 않은 컨텐츠면 기본 0
  final int qnaNum;

  ContentsOverviewEntity({
    required this.id,
    required this.contentsId,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    this.qnaNum = 0,
  });
}
