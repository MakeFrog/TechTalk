import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class BlogOriginPage extends ConsumerStatefulWidget {
  const BlogOriginPage({super.key, required this.blogUrl});

  final String blogUrl;

  static SheetAnchor proportional =
      const SheetAnchor.proportional(0.938); // 722 + 40 / 812;

  @override
  ConsumerState<BlogOriginPage> createState() => _BlogOriginPageState();
}

/// 웹뷰 설정을 위한 유틸리티 클래스
class WebViewInitializer {
  static const String _injectionScript = '''
    // 스크롤 방지하는 스타일 제거
    document.body.style.overflow = 'auto';
    document.documentElement.style.overflow = 'auto';
    document.body.style.position = 'static';
    
    // fixed/sticky 요소 제거
    document.querySelectorAll('.fixed, .sticky, [style*="position: fixed"], [style*="position: sticky"]').forEach(function(el) {
      el.style.position = 'static';
    });
    
    // 터치 이벤트 방지 제거
    document.body.style.touchAction = 'auto';
    document.documentElement.style.touchAction = 'auto';
    
    // 뷰포트 설정
    var meta = document.querySelector('meta[name="viewport"]');
    if (!meta) {
      meta = document.createElement('meta');
      meta.name = 'viewport';
      document.head.appendChild(meta);
    }
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';

    // 텍스트 선택 방지
    document.body.style.webkitUserSelect = 'none';
    document.body.style.userSelect = 'none';
    
    // 이미지 드래그 방지
    document.querySelectorAll('img').forEach(function(img) {
      img.style.webkitUserDrag = 'none';
      img.style.userDrag = 'none';
      img.draggable = false;
    });
    
    // 컨텍스트 메뉴 방지
    document.addEventListener('contextmenu', function(e) {
      e.preventDefault();
    });
    
    // 터치 이벤트로 인한 선택 방지
    document.addEventListener('touchstart', function(e) {
      if (e.touches.length > 1) {
        e.preventDefault();
      }
    }, { passive: false });
    
    // 복사 방지
    document.addEventListener('copy', function(e) {
      e.preventDefault();
    });
    
    // 드래그 방지
    document.addEventListener('dragstart', function(e) {
      e.preventDefault();
    });
  ''';

  static InAppWebViewSettings initializeSettings() {
    return InAppWebViewSettings(
      supportZoom: false,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      javaScriptEnabled: true,
      useOnLoadResource: true,
      allowsBackForwardNavigationGestures: true,
      transparentBackground: true,
      disableVerticalScroll: false,
      disableHorizontalScroll: false,
      verticalScrollBarEnabled: true,
      horizontalScrollBarEnabled: true,
      useWideViewPort: true,
      loadWithOverviewMode: true,
      builtInZoomControls: false,
      displayZoomControls: false,
      cacheEnabled: true,
      clearCache: false,
      javaScriptCanOpenWindowsAutomatically: false,
      preferredContentMode: UserPreferredContentMode.RECOMMENDED,
      applicationNameForUserAgent: 'TechTalk-App',
      contentBlockers: [
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: ".*",
          ),
          action: ContentBlockerAction(
              type: ContentBlockerActionType.CSS_DISPLAY_NONE,
              selector:
                  ".fixed, .sticky, [style*='position: fixed'], [style*='position: sticky']"),
        ),
      ],
    );
  }

  static String get injectionScript => _injectionScript;
}

class _BlogOriginPageState extends ConsumerState<BlogOriginPage> {
  bool _isLoading = true;
  InAppWebViewController? _webViewController;
  InAppWebViewSettings? _settings;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    if (kDebugMode && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    if (mounted) {
      setState(() {
        _settings = WebViewInitializer.initializeSettings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_settings == null) {
      return const Center(
        child: CupertinoActivityIndicator(radius: 13),
      );
    }

    return ScrollableSheet(
      maxPosition: BlogOriginPage.proportional,
      minPosition: BlogOriginPage.proportional,
      initialPosition: BlogOriginPage.proportional,
      child: Container(
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Column(
          children: [
            // 드래그 핸들
            const SheetDraggable(
              child: SizedBox(
                height: 22,
                child: Center(
                  child: SizedBox(
                    width: 36,
                    height: 5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey4,
                        borderRadius: BorderRadius.all(Radius.circular(2.5)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 컨텐츠
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: ValueKey(widget.blogUrl),
                    initialUrlRequest: URLRequest(
                      url: WebUri(widget.blogUrl),
                      headers: {
                        'Cache-Control': 'max-age=3600',
                      },
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    initialSettings: _settings!,
                    onProgressChanged: (controller, progress) {
                      if (progress >= 20) {
                        setState(() => _isLoading = false);
                      }
                    },
                    onLoadStop: (controller, url) async {
                      logger.d('블로그 웹뷰 로딩 완료');
                      await controller.evaluateJavascript(
                        source: WebViewInitializer.injectionScript,
                      );
                    },
                    gestureRecognizers: {
                      Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer(),
                      ),
                    },
                    onReceivedError: (controller, request, error) {
                      logger.e('블로그 웹뷰 렌더링 실패 : ${error.description}');
                      setState(() => _isLoading = false);
                    },
                    onReceivedServerTrustAuthRequest:
                        (controller, challenge) async {
                      return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED,
                      );
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      return NavigationActionPolicy.ALLOW;
                    },
                  ),
                  if (_isLoading)
                    Container(
                      color: CupertinoColors.systemBackground.withOpacity(0.7),
                      child: const Center(
                        child: CupertinoActivityIndicator(radius: 13),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }
}
