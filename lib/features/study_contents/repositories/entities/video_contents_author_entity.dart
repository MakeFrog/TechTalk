import 'package:techtalk/features/study_contents/repositories/entities/interface/contents_author_entity.dart';

/// 비디오 컨텐츠 저자 정보
class VideoContentsAuthorEntity implements ContentsAuthorEntity {
  @override
  final String id;

  @override
  final String name;

  @override
  final String? homePageUrl;

  @override
  final String? profileImgUrl;

  /// 구독자 수
  final int subscribers;

  VideoContentsAuthorEntity({
    required this.id,
    required this.name,
    required this.homePageUrl,
    required this.profileImgUrl,
    required this.subscribers,
  });
}
