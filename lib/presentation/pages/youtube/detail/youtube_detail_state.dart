import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';
import 'package:techtalk/presentation/pages/youtube/detail/constant/youtube_play_state.enum.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_bookmark_checked_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_interview_progress_ready_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/related_youtube_videos_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/selected_youtube_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_main_info_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_player_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_summary_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_video_data_provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

mixin class YoutubeDetailState {
  ///
  /// 메인 유튜브 콘텐츠 정보
  /// 전달 받은 argument에 정보가 있는 여부에 따라서
  /// 비동기 호출을 시도함
  ///
  AsyncValue<YoutubeMainEntity> mainInfo(WidgetRef ref) {
    final arg = ref.read(youtubeDetailRouteArgProvider);
    final passedMainInfo = arg.main;

    if (passedMainInfo != null) {
      return AsyncData(passedMainInfo);
    } else {
      return ref.watch(youtubeMainInfoProvider(arg.contentId));
    }
  }

  ///
  /// 유튜브 플레이어가 cued 되었는지 여부
  ///
  bool hasYoutubePlayerCued(WidgetRef ref) {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    return ref.watch(
        youtubePlayerProvider(contentId).select((p) => p.hasYoutubePlayerCued));
  }

  ///
  /// 유튜브 플레이 재생 상태
  ///
  YoutubePlaySate playerState(WidgetRef ref) {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    return ref.watch(youtubePlayerProvider(contentId).select((p) => p.state));
  }

  ///
  /// 유튜브 api에서 불러오는 비디오 관련 데이터
  ///
  AsyncValue<YoutubeCoreVideoEntity> youtubeVideoDataAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeVideoDataProvider(contentsId));

  ///
  /// 이전 단계에서 전달 받은 썸네일 이미지
  ///
  String? passedThumbnailImg(WidgetRef ref) =>
      ref.read(youtubeDetailRouteArgProvider).thumbnailUrl;

  ///
  /// 콘텐츠 요약 정보
  ///
  AsyncValue<SummaryEntity> summaryAsync(WidgetRef ref) {
    final passedSummary = ref.read(youtubeDetailRouteArgProvider).summary;

    return passedSummary != null
        ? AsyncData(passedSummary)
        : ref.watch(
            youtubeSummaryProvider(
              ref.read(youtubeDetailRouteArgProvider).contentId,
            ),
          );
  }

  ///
  /// 선택된 Qna가 최소 한 개 이상인지 여부
  ///
  bool hasAtLeastOneOfQnaSelected(WidgetRef ref) =>
      ref.watch(isInterviewProgressReadyProvider);

  ///
  /// 콘텐츠 문답 리스트
  ///
  AsyncValue<Set<YoutubeQnaEntity>> qnasAsync(WidgetRef ref) {
    final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas;
    return passedQnas != null
        ? AsyncData(passedQnas)
        : ref.watch(
            youtubeContentQnaProvider(
              ref.read(youtubeDetailRouteArgProvider).contentId,
            ),
          );
  }

  ///
  /// 북마크 체크 여부
  ///
  AsyncValue<bool> isBookMarkCheckedAsync(WidgetRef ref) {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    return ref.watch(isBookmarkCheckedProvider(contentId));
  }

  ///
  /// 스크롤 컨트롤러
  ///
  YoutubePlayerController youtubeController(WidgetRef ref) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    return ref.watch(
        youtubePlayerProvider(videoId).select((p) => p.youtubeController));
  }

  ///
  /// 유튜브 관련 영상 리스트
  ///
  AsyncValue<List<VideoOverviewEntity>> relatedVideoAsync(WidgetRef ref) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    return ref.watch(relatedYoutubeVideoProvider(videoId));
  }

  ///
  /// 선택된 면접 질문
  ///
  List<YoutubeQnaEntity> selectedQnas(WidgetRef ref) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas;
    final selectedQnas = ref.watch(selectedYoutubeQnasProvider(videoId,
        passedQnas: passedQnas?.toList() ?? null));
    return selectedQnas;
  }
}
