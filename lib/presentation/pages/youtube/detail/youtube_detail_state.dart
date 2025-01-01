import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_main_info_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_summary_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_video_data_provider.dart';

mixin class YoutubeDetailState {
  ///
  /// 메인 유튜브 콘텐츠 정보
  /// 전달 받은 argument에 정보가 있는 여부에 따라서
  /// 비동기 호출을 시도함
  ///
  AsyncValue<YoutubeContentOverviewEntity> mainInfo(WidgetRef ref) {
    final arg = ref.read(youtubeDetailRouteArgProvider);
    final passedMainInfo = arg.overView;

    if (passedMainInfo != null) {
      return AsyncData(passedMainInfo);
    } else {
      return ref.watch(youtubeMainInfoProvider(arg.contentId));
    }
  }

  ///
  /// 유튜브 api에서 불러오는 비디오 관련 데이터
  ///
  AsyncValue<YoutubeCoreVideoEntity> youtubeVideoDataAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeVideoDataProvider(contentsId));

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
}
