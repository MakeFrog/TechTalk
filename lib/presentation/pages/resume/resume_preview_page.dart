import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_preview_provider.dart';

class ResumePreviewPage extends HookConsumerWidget {
  final String? previewPath;

  const ResumePreviewPage({
    Key? key,
    required this.previewPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(pdfPreviewNotifierProvider);
    final appBar = AppBar(title: const Text('미리보기'));

    useEffect(
      () {
        ref.read(pdfPreviewNotifierProvider).setPreviewPath(previewPath);
        return null;
      },
      [previewPath],
    );

    switch (notifier.mode) {
      /// 경로가 없을 때
      case PreviewMode.none:
        return Scaffold(
          appBar: appBar,
          body: const Center(child: Text('파일 경로가 존재하지 않습니다.')),
        );

      /// 원격 데이터만 존재할 때
      case PreviewMode.network:
        final controller = notifier.webViewController;
        return Scaffold(
          appBar: appBar,
          body: controller == null
              ? const Center(child: Text(''))
              : WebViewWidget(controller: controller),
        );

      /// 로컬 데이터가 존재할 때
      case PreviewMode.local:
        if (notifier.filePath == null) {
          return Scaffold(
            appBar: appBar,
            body: const Center(child: Text('')),
          );
        }

        return Scaffold(
          appBar: appBar,
          body: PDFView(
            filePath: notifier.filePath,
            onViewCreated: notifier.setPdfController,
            onRender: (pages) => notifier.setTotalPages(pages ?? 0),
            onPageChanged: (current, total) {
              notifier.setCurrentPage(current ?? 0);
              notifier.setTotalPages(total ?? 0);
            },
          ),
        );
    }
  }
}
