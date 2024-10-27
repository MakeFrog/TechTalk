import 'package:techtalk/features/contents/repositories/entities/interface/contents_overview_entity.dart';

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

  final String videoId; // 관련 video id

  VideoContentsOverviewEntity({
    required this.id,
    required this.contentsId,
    required this.thumbnailImgUrl,
    required this.contentsTitle,
    required this.videoId,
    this.qnaNum = 0,
  });
}
