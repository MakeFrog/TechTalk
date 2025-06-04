import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:techtalk/app/util/app_logger.dart';

/// 웹뷰 설정을 위한 유틸리티 클래스
class TechTalkWebViewInitializer {
  static const String _defaultInjectionScript = '''
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

  static InAppWebViewSettings getDefaultSettings({
    bool enableJavaScript = true,
    bool supportZoom = false,
    bool allowsBackForwardNavigationGestures = true,
    String? applicationNameForUserAgent,
  }) {
    return InAppWebViewSettings(
      supportZoom: supportZoom,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      javaScriptEnabled: enableJavaScript,
      useOnLoadResource: true,
      allowsBackForwardNavigationGestures: allowsBackForwardNavigationGestures,
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
      applicationNameForUserAgent:
          applicationNameForUserAgent ?? 'TechTalk-App',
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

  static String get defaultInjectionScript => _defaultInjectionScript;
}

/// 공통 웹뷰 위젯
class TechTalkWebView extends ConsumerStatefulWidget {
  const TechTalkWebView({
    super.key,
    required this.url,
    this.headers,
    this.settings,
    this.injectionScript,
    this.loadingWidget,
    this.enableLogging = true,
    this.onWebViewCreated,
    this.onProgressChanged,
    this.onLoadStart,
    this.onLoadStop,
    this.onReceivedError,
    this.shouldOverrideUrlLoading,
    this.onReceivedServerTrustAuthRequest,
    this.gestureRecognizers,
    this.loadingProgressThreshold = 20,
    this.enableBottomSafeArea = false,
  });

  /// 로드할 URL
  final String url;

  /// 요청 헤더
  final Map<String, String>? headers;

  /// 웹뷰 설정 (null인 경우 기본 설정 사용)
  final InAppWebViewSettings? settings;

  /// JavaScript 주입 스크립트 (null인 경우 기본 스크립트 사용)
  final String? injectionScript;

  /// 로딩 위젯 (null인 경우 기본 로딩 위젯 사용)
  final Widget? loadingWidget;

  /// 로그 활성화 여부
  final bool enableLogging;

  /// 로딩 상태를 해제할 진행률 임계값 (기본값: 20)
  final int loadingProgressThreshold;

  /// bottom SafeArea 활성화 여부 (기본값: false)
  final bool enableBottomSafeArea;

  // 콜백 함수들
  final void Function(InAppWebViewController controller)? onWebViewCreated;
  final void Function(InAppWebViewController controller, int progress)?
      onProgressChanged;
  final void Function(InAppWebViewController controller, WebUri? url)?
      onLoadStart;
  final void Function(InAppWebViewController controller, WebUri? url)?
      onLoadStop;
  final void Function(InAppWebViewController controller,
      WebResourceRequest request, WebResourceError error)? onReceivedError;
  final Future<NavigationActionPolicy?> Function(
          InAppWebViewController controller, NavigationAction navigationAction)?
      shouldOverrideUrlLoading;
  final Future<ServerTrustAuthResponse?> Function(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedServerTrustAuthRequest;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  @override
  ConsumerState<TechTalkWebView> createState() => _TechTalkWebViewState();
}

class _TechTalkWebViewState extends ConsumerState<TechTalkWebView> {
  bool _isLoading = true;
  InAppWebViewController? _webViewController;
  InAppWebViewSettings? _settings;
  DateTime? _loadStartTime;

  @override
  void initState() {
    super.initState();
    _loadStartTime = DateTime.now();

    // 명확한 로딩 시작 콘솔 출력
    _logInfo(
        '┌─────────────────────────────────────────────────────────────────────────────');
    _logInfo('│ 🚀 웹뷰 로딩 시작!');
    _logInfo('│ 📱 URL: ${widget.url}');
    _logInfo('│ 📅 시작시각: ${_loadStartTime!.toString().split('.')[0]}');
    _logInfo(
        '└─────────────────────────────────────────────────────────────────────────────');

    if (kDebugMode) {
      print('🔄 [TechTalkWebView] 로딩 시작: ${widget.url}');
    }

    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    if (kDebugMode && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    if (mounted) {
      setState(() {
        _settings =
            widget.settings ?? TechTalkWebViewInitializer.getDefaultSettings();
      });
    }
  }

  void _logInfo(String message) {
    if (widget.enableLogging) {
      logger.i(message);
    }
  }

  void _logDebug(String message) {
    if (widget.enableLogging) {
      logger.d(message);
    }
  }

  void _logError(String message) {
    if (widget.enableLogging) {
      logger.e(message);
    }
  }

  Widget _buildDefaultLoadingWidget() {
    return Container(
      color: CupertinoColors.systemBackground.withOpacity(0.7),
      child: Center(
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? const CupertinoActivityIndicator(radius: 13)
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_settings == null) {
      return widget.loadingWidget ?? _buildDefaultLoadingWidget();
    }

    final webView = Stack(
      children: [
        InAppWebView(
          key: ValueKey(widget.url),
          initialUrlRequest: URLRequest(
            url: WebUri(widget.url),
            headers: widget.headers ??
                {
                  'Cache-Control': 'max-age=3600',
                },
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
            _logDebug('🌐 웹뷰 생성 완료');
            widget.onWebViewCreated?.call(controller);
          },
          initialSettings: _settings!,
          onProgressChanged: (controller, progress) {
            _logDebug('📊 로딩 진행률: $progress%');
            if (progress >= widget.loadingProgressThreshold) {
              setState(() => _isLoading = false);
            }
            widget.onProgressChanged?.call(controller, progress);
          },
          onLoadStart: (controller, url) {
            _logDebug('🚀 웹뷰 로딩 시작: $url');
            widget.onLoadStart?.call(controller, url);
          },
          onLoadStop: (controller, url) async {
            if (_loadStartTime != null) {
              final loadEndTime = DateTime.now();
              final loadDuration = loadEndTime.difference(_loadStartTime!);
              final seconds =
                  (loadDuration.inMilliseconds / 1000).toStringAsFixed(2);

              // 명확한 콘솔 출력
              _logInfo(
                  '┌─────────────────────────────────────────────────────────────────────────────');
              _logInfo('│ 🎉 웹뷰 로딩 완료!');
              _logInfo('│ 📱 URL: ${widget.url}');
              _logInfo(
                  '│ ⏱️  소요시간: ${loadDuration.inMilliseconds}ms ($seconds초)');
              _logInfo('│ 📅 완료시각: ${loadEndTime.toString().split('.')[0]}');
              _logInfo(
                  '└─────────────────────────────────────────────────────────────────────────────');

              // 추가로 dart developer console에도 출력
              if (kDebugMode) {
                print('🚀 [TechTalkWebView] 로딩 완료: $seconds초 소요');
              }
            } else {
              _logInfo('✅ 웹뷰 로딩 완료');
            }

            // JavaScript 주입
            final script = widget.injectionScript ??
                TechTalkWebViewInitializer.defaultInjectionScript;
            if (script.isNotEmpty) {
              await controller.evaluateJavascript(source: script);
              _logDebug('🔧 JavaScript 주입 완료');
            }

            widget.onLoadStop?.call(controller, url);
          },
          gestureRecognizers: widget.gestureRecognizers ??
              {
                Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
                ),
              },
          onReceivedError: (controller, request, error) {
            if (_loadStartTime != null) {
              final loadEndTime = DateTime.now();
              final loadDuration = loadEndTime.difference(_loadStartTime!);
              final seconds =
                  (loadDuration.inMilliseconds / 1000).toStringAsFixed(2);

              // 명확한 오류 콘솔 출력
              _logError(
                  '┌─────────────────────────────────────────────────────────────────────────────');
              _logError('│ ❌ 웹뷰 로딩 실패!');
              _logError('│ 📱 URL: ${widget.url}');
              _logError('│ 🚨 오류: ${error.description}');
              _logError(
                  '│ ⏱️  실패까지 소요시간: ${loadDuration.inMilliseconds}ms ($seconds초)');
              _logError('│ 📅 실패시각: ${loadEndTime.toString().split('.')[0]}');
              _logError(
                  '└─────────────────────────────────────────────────────────────────────────────');

              if (kDebugMode) {
                print(
                    '💥 [TechTalkWebView] 로딩 실패: $seconds초 후 실패 - ${error.description}');
              }
            } else {
              _logError('❌ 웹뷰 렌더링 실패 : ${error.description}');
            }
            setState(() => _isLoading = false);
            widget.onReceivedError?.call(controller, request, error);
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            final response = await widget.onReceivedServerTrustAuthRequest
                ?.call(controller, challenge);
            return response ??
                ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED,
                );
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final policy = await widget.shouldOverrideUrlLoading
                ?.call(controller, navigationAction);
            return policy ?? NavigationActionPolicy.ALLOW;
          },
        ),
        if (_isLoading) widget.loadingWidget ?? _buildDefaultLoadingWidget(),
      ],
    );

    // SafeArea 제어
    if (widget.enableBottomSafeArea) {
      return SafeArea(child: webView);
    } else {
      return SafeArea(
        bottom: false,
        child: webView,
      );
    }
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }
}
