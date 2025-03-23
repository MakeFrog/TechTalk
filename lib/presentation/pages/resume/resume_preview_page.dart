import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_preview_provider.dart';

class ResumePreviewPage extends HookConsumerWidget {
  final String previewPath;

  const ResumePreviewPage({
    Key? key,
    required this.previewPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(pdfPreviewNotifierProvider);
    final appBar = AppBar(title: const Text('미리보기'));

    useEffect(
      () {
        Future.microtask(() {
          ref.read(pdfPreviewNotifierProvider).loadFile(previewPath);
        });
        return null;
      },
      [previewPath],
    );

    if (pdf.isLoading) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (pdf.hasError || pdf.filePath == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(
          child: Text(
            'PDF 파일을 불러오지 못했습니다.\n파일 경로와 권한을 확인해 주세요.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          PDFView(
            filePath: pdf.filePath,
            autoSpacing: false,
            pageSnap: false,
            pageFling: false,
            onRender: (pages) => pdf.setTotalPages(pages ?? 0),
            onError: (error) {
              debugPrint('PDFView onError: $error');
              pdf.setHasError(true);
            },
            onPageError: (page, error) {
              debugPrint('페이지 $page 에서 에러 발생: $error');
              pdf.setHasError(true);
            },
            onViewCreated: pdf.setController,
            onPageChanged: (current, total) {
              pdf.setCurrentPage(current ?? 0);
              pdf.setTotalPages(total ?? 0);
            },
          ),
        ],
      ),
    );
  }
}
