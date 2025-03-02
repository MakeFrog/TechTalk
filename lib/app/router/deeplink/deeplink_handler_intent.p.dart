part of 'deeplink_handler.dart';

///
/// [DeepLinkHandler] 내부 메소드
/// 현재 [_handleInAppNavigation] 인앱 라우팅을 담당하는 메소드만 사용 (1.1.0)
///
extension DeeplinkHandlerIntentExt on DeepLinkHandler {
  Future<void> _handleInAppNavigation(Uri uri) async {
    log('딥링크 진입 : ${uri}');
    final context = await navigationContext;

    final host = DeeplinkHost.getByHostName(uri.host);

    if (host.hasPrefixLandingProgress) {
      const MainRoute().go(context);
      if (host == DeeplinkHost.prefixHomeLanding) {
        globalContainer
            .read(mainBottomNavigationProvider.notifier)
            .changeTab(MainNavigationTab.home);
      }

      if (host == DeeplinkHost.prefixYoutubeLanding) {
        globalContainer
            .read(mainBottomNavigationProvider.notifier)
            .changeTab(MainNavigationTab.youtube);
      }
    }

    // 특정 페이지 이동 처리
    if (uri.pathSegments.isNotEmpty) {
      String page = uri.pathSegments[0];

      /// 콘텐츠 일경우
      if (page == Uri.parse(YoutubeDetailRoute.path).pathSegments[0]) {
        log('컨텐츠 디테일 페이지로 이동 처리');

        // 콘텐츠 ID 추출
        String contentId = uri.pathSegments[1];
        await YoutubeDetailRoute(YoutubeDetailArg.deeplinkOrHasSingleIdArg(
          contentId: contentId,
          thumbnailImage: null,
        )).push(context);

        return;
      }

      /// 유튜브 업로드 실패 화면
      else if (page ==
          Uri.parse(YoutubeContentUploadFailedRoute.path).pathSegments[0]) {
        String errorCode = Uri.splitQueryString(uri.query)['errorCode'] ?? '';
        await YoutubeContentUploadFailedRoute(
          failedType: YoutubeUploadFailedType.getByErrorCode(errorCode),
        ).push(context);
      }
    }

    log('URL에 정의된 페이지가 없습니다: ${uri.toString()}');
  }

  ///****************** 아래 메소드는 아직 사용안됨 *******************///
  /// 업데이트 권유
  /// 추후에 적용
  void _showVersionUpdateAlert(Uri uri) async {
    /// 1. await 홈으로 이동

    /// 2. 알럿 노출
    /// AppDialog.show();
    /// "신규 기능이 출시되었어요 \n업데이트 하시겠어요?"
    const appStoreUrl = 'https://apps.apple.com/app/id123456';
    const playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.example.app';

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(appStoreUrl))) {
        await launchUrl(Uri.parse(appStoreUrl));
      } else {
        print('Cannot launch App Store');
      }
    } else {
      if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
        await launchUrl(Uri.parse(playStoreUrl));
      } else {
        print('Cannot launch Play Store');
      }
    }
  }

  /// 앱 내부에서 정의된 특정 메소드를 실행
  /// 추후 필요시 적용
  void _executeInternalMethod(Uri uri) {}

  /// 외부 웹페이지 및 앱 실행
  void _openExternalPage(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception(Exception('Cannot launch URL'));
      }
    } catch (e) {
      log('외부 페이지 열기 실패: $e');
    }
  }
}
