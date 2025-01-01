import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_qna_response.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_summary_response_entity.dart';
import 'package:techtalk/features/contents/repositories/enums/youtube_content_analyzed_type.dart';
import 'package:techtalk/features/contents/usecases/enums/youtube_upload_failed_type.dart';
import 'package:techtalk/features/contents/usecases/exception/youtube_upload_exception.dart';
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
      /// ex) 테크 영상 X or 개발자 단순 인터뷰 영
      final typeList = [summaryResult.type, qnaAndIdsResult.type];
      if (typeList.any((e) => e == YoutubeContentAnalyzedType.lackOfContent)) {
        throw const YtInvalidVideoContentException();
      }

      if (typeList.any((e) => e == YoutubeContentAnalyzedType.notTech)) {
        throw const YtIsNotTechContentException();
      }

      final targetOverView = YoutubeContentOverviewEntity.fromUploadResponse(
        video: targetVideo,
        qnaAndIds: qnaAndIdsResult,
      );

      ContentsDetailRoute(YoutubeDetailArg.entryFromUpload(
        overView: targetOverView,
        summary: SummaryEntity.fromUploadResponse(summaryResult),
        qnas: qnaAndIdsResult.qnas,
      )).go(await navigationContext);
    } catch (e) {
      log('유튜브 AI 분석 실패 : ${e}');
      final targetException =
          e is YoutubeUploadException ? e : const YtUnknownException();

      final targetType =
          YoutubeUploadFailedType.getByErrorCode(targetException.code);
      YoutubeContentUploadFailedRoute(targetType).go(await navigationContext);
      throw e;
    }
  }
}
