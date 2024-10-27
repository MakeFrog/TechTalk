import 'package:techtalk/features/contents/repositories/entities/video/video_contents_author_entity.dart';

/// YouTube API에서 가져온 비디오 데이터
class YouTubeVideoDataEntity {
  /// 비디오의 아이디, url을 convert 해서 만들 수 있음
  final String videoId;

  /// 비디오 url
  final String videoUrl;

  /// 비디오 컨텐츠의 저자
  final VideoContentsAuthorEntity author;

  /// 비디오 조회수
  final int views;

  /// 비디오 길이
  final Duration videoLength;

  /// 비디오 좋아요 수
  final int likes;

  YouTubeVideoDataEntity({
    required this.videoId,
    required this.videoUrl,
    required this.author,
    required this.views,
    required this.videoLength,
    required this.likes,
  });
}
