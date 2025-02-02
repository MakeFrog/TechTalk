import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/notification/app_local_notification.dart';
import 'package:techtalk/app/router/deeplink/deep_link_define.enum.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_ai_main_theme_response.dart';
import 'package:techtalk/features/youtube/usecases/get_main_summary_theme_use_case.dart';
import 'package:techtalk/presentation/app.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

///
/// 유튜브 영상을 분석하여 분할 요약 + QNA 데이터를 얻고,
/// 최종 병합하여 업로드하는 UseCase
///
///  - 영상 길이 별 요약 노트 (청크 0 ~ N) → [GetSummaryFromYoutubeContentUseCase] (YoutubeAiSummaryResponse)
///  - 영상 핵심 주제 [GetMainSummaryThemeUseCase]
///  - 영상 스킬 직군 매핑 + 면접 질문 추출 -> [GetQnasFromYoutubeContentUseCase]
///  - QNA → 전체 자막 기반 1회
///
///  [Future.wait] 결과:
///    - results[0] → 첫 청크 요약
///    - results[1..N-1] → 나머지 청크 요약들
///    - results.last → QNA
///
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

        summaryFutures.add(
          GetSummaryFromYoutubeContentUseCase().call(
            // 두 번째 파라미터는 "hasBeenDivided" 여부라면, 원하는 대로 넘김
            (
              request.copyWith(captions: chunkCaptions),
              splittedCaptionLists.length > 1
            ),
          ),
        );
      }

      // QNA (전체 자막으로 1회)
      final qnaFuture = GetQnasFromYoutubeContentUseCase().call(request);

      /// 핵심주제
      final mainThemeFuture = GetMainSummaryThemeUseCase().call(request);

      // 4) 병렬 실행
      //    results[0..N-1]: summaryFutures, results.last: qnaFuture
      final futures = [
        qnaFuture,
        mainThemeFuture,
        ...summaryFutures,
      ];
      final results = await Future.wait(futures);

      // 5) 결과 분류
      final qnaAndIdsResult = results[0] as YoutubeAiQnaAndIdsResponse;
      final mainSummary = results[1] as YoutubeAiMainThemeResponse;

      // 청크 요약들
      final remainSummaries = results
          .sublist(2) // 2부터 끝까지 전부가 요약들
          .map((e) => e as List<ParagraphEntity>)
          .toList();

      // 6) 요약 병합
      //    - 첫 청크 mainTheme + 모든 paragraph
      final allParagraphs = <ParagraphEntity>[];

      for (final rs in remainSummaries) {
        allParagraphs.addAll(rs);
      }
      // 시간순 정렬
      allParagraphs.sort((a, b) {
        final aTime = a.timestamp ?? const Duration(hours: 10);
        final bTime = b.timestamp ?? const Duration(hours: 10);
        return aTime.compareTo(bTime);
      });

      final mergedSummary = SummaryEntity(
        mainTheme: mainSummary.mainTheme,
        summaries: allParagraphs,
      );

      // 최종 YoutubeAiSummaryResponse
      final mergedSummaryResponse = mergedSummary;

      // 7) 유효성 체크 (테크 영상인지 여부)
      if ([mainSummary.type, qnaAndIdsResult.type]
          .any((e) => e == YoutubeContentAnalyzedType.notTech)) {
        throw const YtIsNotTechContentException();
      }

      if ([mainSummary.type, qnaAndIdsResult.type]
              .any((e) => e == YoutubeContentAnalyzedType.lackOfContent) ||
          qnaAndIdsResult.qnas.isEmpty) {
        throw const YtInvalidVideoContentException();
      }

      // 8) 요약된 내용이 있는지 여부
      if (mergedSummary.summaries.isEmpty ||
          mergedSummary.mainTheme.isEmpty ||
          mergedSummary.summaries
              .any((e) => e.title.isEmpty || e.contents.isEmpty)) {
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
            title: tr(LocaleKeys.notificationPermission_uploadSuccessTitle),
            description:
                tr(LocaleKeys.notificationPermission_uploadSuccessDescription),
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
          title: tr(LocaleKeys.notificationPermission_uploadSuccessTitle),
          description:
              tr(LocaleKeys.notificationPermission_uploadSuccessDescription),
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
            title: tr(LocaleKeys.notificationPermission_uploadFailTitle),
            description: tr(targetType.description),
            host: DeeplinkHost.landing,
            path: '',
          );
        }
      } else {
        await AppLocalNotification().triggerPush(
          title: tr(LocaleKeys.notificationPermission_uploadFailTitle),
          description: tr(targetType.description),
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
