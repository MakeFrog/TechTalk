import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:techtalk/presentation/widgets/common/webview/techtalk_web_view.dart';

class BlogOriginPage extends ConsumerStatefulWidget {
  const BlogOriginPage({super.key, required this.blogUrl});

  final String blogUrl;

  static SheetAnchor proportional =
      const SheetAnchor.proportional(0.938); // 722 + 40 / 812;

  @override
  ConsumerState<BlogOriginPage> createState() => _BlogOriginPageState();
}

class _BlogOriginPageState extends ConsumerState<BlogOriginPage> {
  @override
  Widget build(BuildContext context) {
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
                height: 32,
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
              child: TechTalkWebView(
                url: widget.blogUrl,
                headers: const {
                  'Cache-Control': 'max-age=3600',
                },
                enableLogging: true,
                loadingProgressThreshold: 20,
                enableBottomSafeArea: false,
                gestureRecognizers: {
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
