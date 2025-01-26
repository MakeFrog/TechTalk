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
import 'package:techtalk/presentation/app.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/main/provider/selected_filter_category_provider.dart';
import 'package:techtalk/presentation/pages/youtube/main/provider/youtube_content_pagination_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

///
/// 유튜브 영상을 분석하여 기대값을 반환받고 업로드하는 useCase
/// [GetSummaryFromYoutubeContentUseCase], [GetQnasFromYoutubeContentUseCase]
/// 을 통해 요약, 테크 영상 여부, 스킬 직군 카테고리, 면접질문 데이터를 반환 받음
///
final class AnalyzeAndUploadYoutubeUseCase
    extends BaseUseCase<YoutubeVideoEntity, void> with WidgetsBindingObserver {
  /// 앱이 백그라운드에 있는지 여부
  bool isInBackground = false;

  @override
  Future<void> call(YoutubeVideoEntity request) async {
    WidgetsBinding.instance.addObserver(this);
    final targetVideo = request;

    final context = await navigationContext;

    try {
      isInBackground = false;
      final responses = await Future.wait([
        GetSummaryFromYoutubeContentUseCase().call(targetVideo),
        GetQnasFromYoutubeContentUseCase().call(targetVideo),
      ]);

      final summaryResult = responses[0] as YoutubeAiSummaryResponse;
      final qnaAndIdsResult = responses[1] as YoutubeAiQnaAndIdsResponse;

      /// 분석 가능한 영상이 아닐 경우
      /// ex) 테크 영상 X or 개발자 단순 인터뷰 영상
      final typeList = [summaryResult.type, qnaAndIdsResult.type];
      if (typeList.any((e) => e == YoutubeContentAnalyzedType.lackOfContent)) {
        throw const YtInvalidVideoContentException();
      }

      if (typeList.any((e) => e == YoutubeContentAnalyzedType.notTech)) {
        throw const YtIsNotTechContentException();
      }

      final targetOverView = YoutubeMainEntity.fromUploadResponse(
        video: targetVideo,
        qnaAndIds: qnaAndIdsResult,
      );
      final userId =
          (await globalContainer.read(userInfoProvider.future))?.uid ??
              'undefined';

      /// 현재 분석 화면에 머물러 있을 경우
      /// 해당 페이지로 바로 라우팅
      if (_isOnAnalyzePage(context)) {
        YoutubeDetailRoute(
          YoutubeDetailArg.entryFromUpload(
            overView: targetOverView,
            summary: SummaryEntity.fromUploadResponse(summaryResult),
            qnas: qnaAndIdsResult.qnas,
          ),
        ).go(await navigationContext);
        unawaited(_uploadContent(
          targetOverView,
          summaryResult,
          qnaAndIdsResult.qnas,
          userId,
        ));

        if (isInBackground) {
          await AppLocalNotification().triggerBackgroundPush(
            title: '영상 업로드 했어요 1',
            description: '요약된 핵심 내용을 확인하고 면접을 진행해 보세요!',
            host: DeeplinkHost.landing,
            path: '',
          );
        }
      } else {
        await _uploadContent(
          targetOverView,
          summaryResult,
          qnaAndIdsResult.qnas,
          userId,
        );

        await AppLocalNotification().triggerBackgroundPush(
          title: '영상 업로드 했어요',
          description: '요약된 핵심 내용을 확인하고 면접을 진행해 보세요!',
          host: DeeplinkHost.prefixYoutubeLanding,
          path:
              '${Uri.parse(YoutubeDetailRoute.path).pathSegments[0]}/${targetOverView.id}',
        );
      }

      WidgetsBinding.instance.removeObserver(this);
    } catch (e) {
      log('유튜브 AI 분석 실패 : $e');
      final targetException =
          e is YoutubeUploadException ? e : const YtUnknownException();

      final targetType =
          YoutubeUploadFailedType.getByErrorCode(targetException.code);
      final String? targetCardId = targetException is YtAlreadyUploadedException
          ? (e as YtAlreadyUploadedException).contentId
          : null;

      if (_isOnAnalyzePage(context)) {
        YoutubeContentUploadFailedRoute(
                contentId: targetCardId, failedType: targetType)
            .go(await navigationContext);

        if (isInBackground) {
          await AppLocalNotification().triggerBackgroundPush(
            title: '영상을 업로드하는데 실팼어요',
            description: targetType.description,
            host: DeeplinkHost.landing,
            path: '',
          );
        }
      } else {
        await AppLocalNotification().triggerBackgroundPush(
            title: '영상을 업로드하는데 실팼어요',
            description: targetType.description,
            host: DeeplinkHost.prefixYoutubeLanding,
            path:
                '${Uri.parse(YoutubeContentUploadFailedRoute.path).pathSegments[0]}?errorCode=${targetType.code}');
      }

      WidgetsBinding.instance.removeObserver(this);
    }
  }

  /// 업로드 및 분석 화면에 현재 머물러 있느지 여부
  bool _isOnAnalyzePage(BuildContext context) {
    return GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .fullPath
        .contains(AnalyzeYoutubeRoute.path);
  }

  ///
  /// 현재 라우팅 path에 따라
  /// 영상 업로드 메소드 [await] [unawaited] 여부를 결정함
  ///
  Future<void> _uploadContent(
      YoutubeMainEntity targetOverView,
      YoutubeAiSummaryResponse summaryResult,
      Set<YoutubeQnaEntity> qnas,
      String userId) async {
    await youtubeRepository
        .uploadYoutube(
          contentMainInfo: targetOverView,
          summary: SummaryEntity.fromUploadResponse(summaryResult),
          qnas: qnas,
          uploaderId: userId,
          uploadLanguageCode: AppLocale.currentLocale.languageCode,
        )
        .then(
          (response) => response.fold(
            onSuccess: (_) {
              /// 영항 학습 탭뷰 페이징 컨트롤러 초기화
              final categories = globalContainer
                  .read(youtubeContentCategoryProvider)
                  .totalCategories;
              for (var category in categories) {
                if (globalContainer.exists(
                    youtubeContentPaginationProvider(category: category))) {
                  globalContainer
                      .read(
                          youtubeContentPaginationProvider(category: category))
                      .refresh();
                }
              }

              log('유튜브 영상 업로드 성공');
            },
            onFailure: (e) {
              log('유튜브 영상 업로드 실패 : $e');
            },
          ),
        );
  }

  // flutter: app in inactive
  // flutter: app in hiddent
  // flutter: app in paused

  // flutter: app in hiddent
  // flutter: app in inactive
  // flutter: app in resumed

  /// 앱이 백그라운드 상태에 진입했는지 여부를 판단하고
  /// 상태값을 변경
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && !isInBackground) {
      isInBackground = true;
    } else {
      if (isInBackground) {
        isInBackground = false;
      }
    }
  }
}
