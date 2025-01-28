import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';

final class YoutubeInterviewRoomEntity {
  final String contentTitle;
  final VideoOverviewEntity? relatedVideo;

  YoutubeInterviewRoomEntity({
    required this.contentTitle,
    required this.relatedVideo,
  });
}
