import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_qna_response.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_summary_response_entity.dart';
import 'package:techtalk/features/contents/usecases/exception/youtube_ai_analyze_exception.dart';
import 'package:techtalk/features/contents/usecases/get_qnas_from_youtube_content_use_case.dart';
import 'package:techtalk/features/contents/usecases/get_summary_from_youtube_content_use_case.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_contents_detail_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/target_youtube_info_provider.dart';

part 'analyzed_youtube_content_fetcher_provider.g.dart';

@riverpod
class AnalyzedYoutubeFetcher extends _$AnalyzedYoutubeFetcher {
  @override
  Future<void> build() async {
    final targetVideo = await ref.watch(targetYoutubeInfoProvider.future);

    try {
      final responses = await Future.wait([
        GetSummaryFromYoutubeContentUseCase().call(targetVideo),
        GetQnasFromYoutubeContentUseCase().call(targetVideo),
      ]);

      final summaryResult = responses[0] as YoutubeAiSummaryResponse;
      final qnaAndIdsResult = responses[1] as YoutubeAiQnaAndIdsResponse;

      /// 분석 가능한 영상이 아닐 경우
      /// ex) 테크 영상 X or 개발자 단순 인터뷰 영상
      if (summaryResult.type.isInvalid || qnaAndIdsResult.type.isInvalid) {
        print('여기다');
        throw const YtInvalidVideoContent();
      }

      final targetOverView = YoutubeContentOverviewEntity.fromUploadResponse(
        video: targetVideo,
        qnaAndIds: qnaAndIdsResult,
      );

      ContentsDetailRoute(YoutubeDetailArg.entryFromUpload(
        overView: targetOverView,
        summary: SummaryEntity.fromUploadResponse(summaryResult),
        qnas: qnaAndIdsResult.qnas,
      )).go((await navigationContext));
    } catch (e) {
      log('유튜브 AI 분석 실패 : ${e}');
      throw e;
    }
  }
}
