import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class BlogOriginPage extends ConsumerWidget {
  const BlogOriginPage({super.key, required this.blogUrl});

  final String blogUrl;

  static SheetAnchor minProportional =
      const SheetAnchor.proportional(0.856); // 655 + 40 / 812
  static SheetAnchor maxProportional =
      const SheetAnchor.proportional(0.938); // 722 + 40 / 812;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollableSheet(
      maxPosition: maxProportional,
      minPosition: minProportional,
      initialPosition: minProportional,
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
              child: Column(
                children: [
                  CupertinoNavigationBar(
                    middle: const Text('블로그 선택'),
                    leading: const CloseButton(),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('테스트 뷰'),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => _TestListView(),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: WebUri(blogUrl)),
                      initialSettings: InAppWebViewSettings(
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
                      ),
                      onLoadStart: (controller, url) {
                        logger.d('블로그 웹뷰 로딩 시작');
                      },
                      onLoadStop: (controller, url) async {
                        logger.d('블로그 웹뷰 로딩 완료');
                        // 웹뷰 로드 완료 후 JavaScript 실행
                        await controller.evaluateJavascript(source: '''
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
                        ''');
                      },
                      gestureRecognizers: {
                        Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer()),
                      },
                      onReceivedError: (controller, request, error) {
                        logger.e('블로그 웹뷰 렌더링 실패 : ${error.description}');
                      },
                      onReceivedServerTrustAuthRequest:
                          (controller, challenge) async {
                        logger.d('SSL 인증서 검증 요청');
                        return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED,
                        );
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        logger.d('URL 로딩 요청: ${navigationAction.request.url}');
                        return NavigationActionPolicy.ALLOW;
                      },
                      onScrollChanged: (controller, x, y) {
                        logger.d('스크롤 변경: x=$x, y=$y');
                      },
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
}

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Text('닫기'),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _TestListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      maxPosition: BlogOriginPage.maxProportional,
      minPosition: BlogOriginPage.minProportional,
      initialPosition: BlogOriginPage.minProportional,
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
              child: Column(
                children: [
                  const CupertinoNavigationBar(
                    middle: Text('테스트 리스트'),
                    leading: CloseButton(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '테스트 아이템 $index',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
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
}
