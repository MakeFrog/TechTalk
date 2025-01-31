import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';

part 'recommended_youtube_video_provider.g.dart';

///
/// [InterviewType]이 youtube인 경우
/// 면접이 종료되고 보여지는 [InterviewIndicatorCard] 다이어로그에서
/// 관련 콘텐츠를 추천할 떄 보여지는 비디오 정보
/// 이전 화면에서 전달 받았다면 별도의 api call을 하지 않음.
///
@riverpod
class RecommendedYoutubeVideo extends _$RecommendedYoutubeVideo {
  @override
  Future<VideoOverviewEntity> build() async {
    final youtubeExtra = ref.read(selectedChatRoomProvider).youtubeExtra;

    final passedVideo = youtubeExtra?.relatedVideo;
    if (passedVideo != null) return passedVideo;

    final response =
        await youtubeRepository.getRelatedVideo(youtubeExtra?.contentId ?? '');
    return response.fold(
      onSuccess: (relatedVideos) {
        return relatedVideos.first;
      },
      onFailure: (e) {
        logger.e(e);
        throw e;
      },
    );
  }
}
