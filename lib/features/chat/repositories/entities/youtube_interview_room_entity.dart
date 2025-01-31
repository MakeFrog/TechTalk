import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';

final class YoutubeInterviewRoomEntity {
  final String contentTitle;
  final String contentId;
  final VideoOverviewEntity? relatedVideo;

  const YoutubeInterviewRoomEntity({
    required this.contentId,
    required this.contentTitle,
    required this.relatedVideo,
  });
}
