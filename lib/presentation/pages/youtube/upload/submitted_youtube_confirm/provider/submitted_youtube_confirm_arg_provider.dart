import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_video_entity.dart';

part 'submitted_youtube_confirm_arg_provider.g.dart';

@riverpod
SubmittedYoutubeConfirmArg submittedYoutubeConfirmArg(
    SubmittedYoutubeConfirmArgRef ref) {
  return throw Exception('submittedYoutubeConfirmArg > 인자를 초기화 해야 됩니다');
}

final class SubmittedYoutubeConfirmArg {
  // 비디오 정보
  final YoutubeVideoEntity video;

  // 비디오 정보를 호출했는지 여부
  final bool hasFetchedMetaInfo;

  SubmittedYoutubeConfirmArg._({
    required this.video,
    required this.hasFetchedMetaInfo,
  });

  /// 일반 업로드 flow
  /// 해당 flow의 경우 이전에 캡션 정보를 호출하여 [video]에 매핑이 되어 있음.
  factory SubmittedYoutubeConfirmArg.fromNormalFlow({
    required YoutubeVideoEntity video,
  }) =>
      SubmittedYoutubeConfirmArg._(video: video, hasFetchedMetaInfo: true);

  /// 테크톡에서 영상 정보를 클릭하여 진입한 flow
  factory SubmittedYoutubeConfirmArg.fromContentAccessFlow({
    required YoutubeVideoEntity video,
  }) =>
      SubmittedYoutubeConfirmArg._(video: video, hasFetchedMetaInfo: false);
}
