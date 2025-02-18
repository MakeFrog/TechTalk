import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';

class ResumePreviewPage extends HookConsumerWidget with ResumeManageEvent {
  final String previewPath;

  const ResumePreviewPage({Key? key, required this.previewPath})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPages = useState<int>(0);
    final currentPage = useState<int>(0);
    final isLoading = useState<bool>(true);
    final hasError = useState<bool>(false);
    final pdfViewController = useState<PDFViewController?>(null);

    // 파일 존재 여부 체크 - useEffect 활용
    useEffect(
      () {
        final file = File(previewPath);
        if (!file.existsSync()) {
          hasError.value = true;
        }
        return null;
      },
      [previewPath],
    );

    // 파일이 없거나 접근 불가능하면 에러 UI
    if (hasError.value) {
      return Scaffold(
        appBar: AppBar(title: const Text('미리보기')),
        body: const Center(
          child: Text(
            'PDF 파일을 불러오지 못했습니다.\n파일 경로와 권한을 확인해 주세요.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('미리보기')),
      body: Stack(
        children: [
          PDFView(
            filePath: previewPath,
            autoSpacing: false,
            pageSnap: false,
            pageFling: false,
            onRender: (pages) {
              isLoading.value = false;
              totalPages.value = pages ?? 0;
            },
            onError: (error) {
              debugPrint(error.toString());
              hasError.value = true;
            },
            onPageError: (page, error) {
              debugPrint('페이지 $page 에서 에러 발생: $error');
            },
            onViewCreated: (PDFViewController controller) {
              pdfViewController.value = controller;
            },
            onPageChanged: (int? current, int? total) {
              currentPage.value = current ?? 0;
              totalPages.value = total ?? 0;
            },
          ),
          if (isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: _buildNavigationButtons(
        context: context,
        pdfViewController: pdfViewController,
        currentPage: currentPage,
        totalPages: totalPages,
      ),
    );
  }

  /// 페이지 이동 버튼
  Widget? _buildNavigationButtons({
    required BuildContext context,
    required ValueNotifier<PDFViewController?> pdfViewController,
    required ValueNotifier<int> currentPage,
    required ValueNotifier<int> totalPages,
  }) {
    // 필요에 따라 버튼을 표시하지 않을 수도 있음
    if (totalPages.value <= 1) {
      return null;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 이전 페이지 버튼
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final page = await pdfViewController.value?.getCurrentPage() ?? 0;
            if (page > 0) {
              await pdfViewController.value?.setPage(page - 1);
            }
          },
          child: const Icon(Icons.chevron_left),
        ),
        const SizedBox(width: 8),
        // 다음 페이지 버튼
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final page = await pdfViewController.value?.getCurrentPage() ?? 0;
            if (page + 1 < totalPages.value) {
              await pdfViewController.value?.setPage(page + 1);
            }
          },
          child: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
