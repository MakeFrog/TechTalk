import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/notification/app_local_notification.dart';
import 'package:techtalk/app/router/deeplink/deep_link_define.enum.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/usecases/get_remain_summary_form_youtube_content_use_case.dart';
import 'package:techtalk/presentation/app.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///
/// 유튜브 영상을 분석하여 분할 요약 + QNA 데이터를 얻고,
/// 최종 병합하여 업로드하는 UseCase
///
///  - 0번 청크 → [GetSummaryFromYoutubeContentUseCase] (YoutubeAiSummaryResponse)
///  - 1~N번 청크 → [GetRemainSummaryFromYoutubeContentUseCase] (SummaryEntity, mainTheme="")
///  - QNA → 전체 자막 기반 1회
///
///  [Future.wait] 결과:
///    - results[0] → 첫 청크 요약
///    - results[1..N-1] → 나머지 청크 요약들
///    - results.last → QNA
///
final class AnalyzeAndUploadYoutubeUseCase
    extends BaseUseCase<YoutubeVideoEntity, void> with WidgetsBindingObserver {
  bool isInBackground = false;

  @override
  Future<void> call(YoutubeVideoEntity request) async {
    WidgetsBinding.instance.addObserver(this);

    final context = await navigationContext;
    final duration = request.duration ?? Duration.zero;

    // 1) 청크 개수 구하기
    final chunkCount = _getChunkCount(duration);
    log('영상길이: ${duration.inMinutes}분 → 청크: $chunkCount');

    // 2) 자막 분할
    List<List<CaptionEntity>> splittedCaptionLists;
    if (chunkCount > 1) {
      splittedCaptionLists = _splitCaptionsIntoChunkLists(
        captions: request.captions,
        totalDuration: duration,
        chunkCount: chunkCount,
      );
    } else {
      // 분할 없음
      splittedCaptionLists = [request.captions];
    }

    try {
      // 3) 청크별 Future 준비
      //  - 첫 청크(인덱스=0): [GetSummaryFromYoutubeContentUseCase]
      //  - 나머지 청크(인덱스>=1): [GetRemainSummaryFromYoutubeContentUseCase]
      final summaryFutures = <Future>[];
      for (int i = 0; i < splittedCaptionLists.length; i++) {
        final chunkCaptions = splittedCaptionLists[i];

        if (i == 0) {
          // 첫 청크 → 정식 요약 (YoutubeAiSummaryResponse)
          summaryFutures.add(
            GetSummaryFromYoutubeContentUseCase().call(
              // 두 번째 파라미터는 "hasBeenDivided" 여부라면, 원하는 대로 넘김
              (
                request.copyWith(captions: chunkCaptions),
                splittedCaptionLists.length > 1
              ),
            ),
          );
        } else {
          // 나머지 청크 → 잔여 요약 (SummaryEntity, mainTheme="")
          summaryFutures.add(
            GetRemainSummaryFromYoutubeContentUseCase().call(
              (request.copyWith(captions: chunkCaptions), i),
            ),
          );
        }
      }

      // QNA (전체 자막으로 1회)
      final qnaFuture = GetQnasFromYoutubeContentUseCase().call(request);

      // 4) 병렬 실행
      //    results[0..N-1]: summaryFutures, results.last: qnaFuture
      final futures = [...summaryFutures, qnaFuture];
      final results = await Future.wait(futures);

      // 5) 결과 분류
      //    - 마지막 → QNA
      final qnaAndIdsResult = results.last as YoutubeAiQnaAndIdsResponse;

      //    - 첫 번째 → 첫 청크 요약
      final firstSummary = results.first as SummaryEntity;

      //    - 1..(length - 2) → 나머지 청크 요약
      final remainSummaries = results
          .sublist(1, results.length - 1)
          .map((e) => e as SummaryEntity)
          .toList();

      // 6) 요약 병합
      //    - 첫 청크 mainTheme + 모든 paragraph
      final allParagraphs = <ParagraphEntity>[];
      allParagraphs.addAll(firstSummary.summaries);
      for (final rs in remainSummaries) {
        allParagraphs.addAll(rs.summaries);
      }
      // 시간순 정렬
      allParagraphs.sort((a, b) {
        final aTime = a.timestamp ?? const Duration(hours: 10);
        final bTime = b.timestamp ?? const Duration(hours: 10);
        return aTime.compareTo(bTime);
      });

      final mergedSummary = SummaryEntity(
        mainTheme: firstSummary.mainTheme,
        summaries: allParagraphs,
      );

      // 최종 YoutubeAiSummaryResponse
      final mergedSummaryResponse = mergedSummary;

      // 7) 유효성 체크 (테크 영상인지 여부)
      if (qnaAndIdsResult.type == YoutubeContentAnalyzedType.lackOfContent ||
          qnaAndIdsResult.qnas.isEmpty) {
        throw const YtInvalidVideoContentException();
      }

      if (qnaAndIdsResult.type == YoutubeContentAnalyzedType.notTech) {
        throw const YtIsNotTechContentException();
      }

      // 8) 요약된 내용이 있는지 여부
      if (mergedSummaryResponse.summaries.isEmpty ||
          mergedSummaryResponse.mainTheme.isEmpty ||
          mergedSummaryResponse.summaries.any((e) => e.title.isEmpty)) {
        throw const YtInvalidVideoContentException();
      }

      // 8) 업로드 및 라우팅/알림
      final youtubeMainEntity = YoutubeMainEntity.fromUploadResponse(
        video: request,
        qnaAndIds: qnaAndIdsResult,
      );

      if (_isOnAnalyzePage(context)) {
        // 상세 페이지로 이동
        YoutubeDetailRoute(
          YoutubeDetailArg.entryFromUpload(
            overView: youtubeMainEntity,
            summary: mergedSummary,
            qnas: qnaAndIdsResult.qnas.toList(),
          ),
        ).go(await navigationContext);

        // 업로드는 비동기로 처리
        unawaited(
          _uploadContent(
            youtubeMainEntity,
            mergedSummaryResponse,
            qnaAndIdsResult.qnas,
          ),
        );

        if (isInBackground) {
          await AppLocalNotification().triggerPush(
            title: '영상 업로드 했어요',
            description: '요약된 내용을 확인해 보세요!',
            host: DeeplinkHost.landing,
            path: '',
          );
        }
      } else {
        // 업로드 완료 후 알림
        await _uploadContent(
          youtubeMainEntity,
          mergedSummaryResponse,
          qnaAndIdsResult.qnas,
        );
        await AppLocalNotification().triggerPush(
          title: '영상 업로드 했어요',
          description: '요약된 내용을 확인해 보세요!',
          host: DeeplinkHost.prefixYoutubeLanding,
          path:
              '${Uri.parse(YoutubeDetailRoute.path).pathSegments[0]}/${youtubeMainEntity.id}',
        );
      }

      WidgetsBinding.instance.removeObserver(this);
    } catch (e) {
      log('유튜브 AI 분석 실패 : $e');
      final targetException =
          e is YoutubeUploadException ? e : const YtUnknownException();

      final targetType =
          YoutubeUploadFailedType.getByErrorCode(targetException.code);
      final Video? alreadyUploadedVideo =
          targetException is YtAlreadyUploadedException
              ? (e as YtAlreadyUploadedException).video
              : null;

      if (_isOnAnalyzePage(context)) {
        YoutubeContentUploadFailedRoute(
          $extra: alreadyUploadedVideo,
          failedType: targetType,
        ).go(await navigationContext);

        if (isInBackground) {
          await AppLocalNotification().triggerPush(
            title: '영상을 업로드하는데 실패했어요',
            description: targetType.description,
            host: DeeplinkHost.landing,
            path: '',
          );
        }
      } else {
        await AppLocalNotification().triggerPush(
          title: '영상을 업로드하는데 실패했어요',
          description: targetType.description,
          host: DeeplinkHost.prefixYoutubeLanding,
          path:
              '${Uri.parse(YoutubeContentUploadFailedRoute.path).pathSegments[0]}?errorCode=${targetType.code}',
        );
      }

      WidgetsBinding.instance.removeObserver(this);
    }
  }

  /// 자막을 [chunkCount]만큼 실제로 분할
  ///
  /// 정밀도를 위해 inMilliseconds로 계산.
  /// 예) 전체가 20분3.799초=1203799ms, chunkCount=2 => chunkSize≈601899ms
  ///  → 0번청크=[0..601898ms], 1번청크=[601899..1203798ms]
  List<List<CaptionEntity>> _splitCaptionsIntoChunkLists({
    required List<CaptionEntity> captions,
    required Duration totalDuration,
    required int chunkCount,
  }) {
    final totalMs = totalDuration.inMilliseconds;
    final chunkSize = (totalMs / chunkCount).floor();

    final splitted = List.generate(chunkCount, (_) => <CaptionEntity>[]);

    for (final c in captions) {
      final offsetMs = c.end.inMilliseconds;
      var index = offsetMs ~/ chunkSize;
      if (index >= chunkCount) {
        index = chunkCount - 1; // 마지막 청크로
      }
      splitted[index].add(c);
    }

    return splitted;
  }

  /// 업로드 로직
  Future<void> _uploadContent(
    YoutubeMainEntity targetOverView,
    SummaryEntity summaryResult,
    Set<YoutubeQnaEntity> qnas,
  ) async {
    // return;
    // Firestore/서버 업로드 로직
    // return;

    await youtubeRepository.uploadYoutube(
      contentMainInfo: targetOverView,
      summary: summaryResult,
      qnas: qnas,
      uploaderId: globalContainer.read(userInfoProvider).value?.uid ?? '',
      uploadLanguageCode: AppLocale.getLocaleName(),
    );
  }

  /// 청크 개수 산정
  int _getChunkCount(Duration duration) {
    if (duration >= const Duration(minutes: 60)) return 5;
    if (duration >= const Duration(minutes: 40)) return 4;
    if (duration >= const Duration(minutes: 25)) return 3;
    if (duration >= const Duration(minutes: 12)) return 2;
    return 1;
  }

  /// 현재 라우팅이 분석 페이지인지 여부
  bool _isOnAnalyzePage(BuildContext context) {
    return GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .fullPath
        .contains(AnalyzeYoutubeRoute.path);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && !isInBackground) {
      isInBackground = true;
    } else if (isInBackground) {
      isInBackground = false;
    }
  }
}
