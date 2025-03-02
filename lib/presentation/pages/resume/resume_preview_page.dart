import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';

class ResumePreviewPage extends HookConsumerWidget with ResumeManageEvent {
  final String previewPath; // registDocumentBtn에서 저장된 절대 경로 그대로

  const ResumePreviewPage({Key? key, required this.previewPath})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PDF 페이지 수 / 현재 페이지 / 로딩 상태
    final totalPages = useState<int>(0);
    final currentPage = useState<int>(0);
    final isLoading = useState<bool>(true);

    // PDF 파일 경로 / 에러 여부 / PDFView Controller
    final validPath = useState<String?>(null);
    final hasError = useState<bool>(false);
    final pdfViewController = useState<PDFViewController?>(null);

    // 1) 화면이 처음 띄워질 때, previewPath의 파일이 유효한지 확인하고,
    //    안 되면 fallback 경로( basename + Documents 폴더 )로 재시도
    // 2) 둘 다 없으면 에러 처리
    useEffect(
      () {
        Future<void> checkFilePath() async {
          try {
            final path = await getValidPath(ref, previewPath);
            validPath.value = path;
          } catch (e) {
            // 파일이 전혀 없으면 hasError=true
            hasError.value = true;
          } finally {
            // 경로 검증 끝
            isLoading.value = false;
          }
        }

        checkFilePath();
        return null;
      },
      [previewPath],
    );

    // 로딩중
    if (isLoading.value) {
      return Scaffold(
        appBar: AppBar(title: const Text('미리보기')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // 에러 or 경로 못 찾은 경우
    if (hasError.value || validPath.value == null) {
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
            filePath: validPath.value,
            autoSpacing: false,
            pageSnap: false,
            pageFling: false,
            onRender: (pages) {
              totalPages.value = pages ?? 0;
            },
            onError: (error) {
              debugPrint('PDFView onError: $error');
              hasError.value = true;
            },
            onPageError: (page, error) {
              debugPrint('페이지 $page 에서 에러 발생: $error');
              hasError.value = true;
            },
            onViewCreated: (controller) {
              pdfViewController.value = controller;
            },
            onPageChanged: (current, total) {
              currentPage.value = current ?? 0;
              totalPages.value = total ?? 0;
            },
          ),
          if (isLoading.value) const Center(child: CircularProgressIndicator()),
        ],
      ),

      // 이전/다음 페이지 이동
      floatingActionButton: _buildNavigationButtons(
        context: context,
        pdfViewController: pdfViewController,
        currentPage: currentPage,
        totalPages: totalPages,
      ),
    );
  }

  /// 페이지 이동 FAB
  Widget? _buildNavigationButtons({
    required BuildContext context,
    required ValueNotifier<PDFViewController?> pdfViewController,
    required ValueNotifier<int> currentPage,
    required ValueNotifier<int> totalPages,
  }) {
    if (totalPages.value <= 1) {
      return null;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 이전 페이지
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final page = await pdfViewController.value?.getCurrentPage() ?? 0;
            if (page > 0) {
              await pdfViewController.value?.setPage(page - 1);
              currentPage.value = page - 1;
            }
          },
          child: const Icon(Icons.chevron_left),
        ),
        const SizedBox(width: 8),

        // 다음 페이지
        FloatingActionButton(
          mini: true,
          onPressed: () async {
            final page = await pdfViewController.value?.getCurrentPage() ?? 0;
            if (page + 1 < totalPages.value) {
              await pdfViewController.value?.setPage(page + 1);
              currentPage.value = page + 1;
            }
          },
          child: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
