import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_detail_ref.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_contents_detail_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_contents_detail_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_main_info_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_summary_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_video_data_provider.dart';

mixin class YoutubeContentsDetailState {
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
  AsyncValue<YouTubeVideoDataEntity> youtubeVideoDataAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeVideoDataProvider(contentsId));

  ///
  /// 테크톡 DB에서 불러오는 해당 비디오 컨텐츠 데이터
  ///
  AsyncValue<YoutubeContentsDetailEntity> youtubeContentsDetailAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeContentsDetailProvider(contentsId));

  ///
  /// 테크톡 DB에서 불러오는 해당 비디오 컨텐츠 데이터
  ///
  @Deprecated('구조 변경으로 사용안함')
  AsyncValue<List<YoutubeQnaEntity>> youtubeContentsDetailQnasAsync(
          WidgetRef ref, String contentsId) =>
      ref.watch(youtubeContentsDetailQnasProvider(contentsId));

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
