import 'package:techtalk/features/study_contents/repositories/entities/interface/contents_overview_entity.dart';

/// 비디오 컨텐츠의 미리보기 엔티티
class VideoContentsOverviewEntity implements ContentsOverviewEntity {
  @override
  final String id;

  @override
  final String contentsId;

  @override
  final String thumbnailImgUrl;

  @override
  final String contentsTitle;

  @override
  final int qnaNum; // 아직 등록되지 않은 비디오면 0이 기본값

  VideoContentsOverviewEntity({
    required this.id,
    required this.contentsId,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    this.qnaNum = 0,
  });
}
