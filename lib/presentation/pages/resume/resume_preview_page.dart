import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:path/path.dart' as p;

class ResumePreviewPage extends HookConsumerWidget with ResumeManageEvent {
  final String previewPath;

  const ResumePreviewPage({
    Key? key,
    required this.previewPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = usePdfPreview(ref, previewPath, getValidPath);
    final appBar = AppBar(title: const Text('미리보기'));

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

///
/// 파일 상대 경로 -> 절대 경로로 변환
///
Future<String> getValidPath(WidgetRef ref, String storedPath) async {
  final storedFile = File(storedPath);

  // 기존 절대 경로 파일이 존재하면 그대로 사용
  if (storedFile.existsSync()) {
    return storedPath;
  }

  // 앱 내부 Documents 디렉토리를 구해 basename과 결합
  final docDir = await getApplicationDocumentsDirectory();
  final fileName = p.basename(storedPath);
  final fallbackPath = p.join(docDir.path, fileName);
  final fallbackFile = File(fallbackPath);

  if (fallbackFile.existsSync()) {
    return fallbackPath;
  }
  throw Exception('파일을 찾을 수 없습니다.');
}

///
/// PDF 뷰어와 관련된 로컬 상태(로딩, 페이지 수, 컨트롤러 등) 관리
///
PdfPreviewData usePdfPreview(
  WidgetRef ref,
  String previewPath,
  Future<String> Function(WidgetRef ref, String path) getValidPathFn,
) {
  // 상태 정의
  final isLoading = useState(true);
  final hasError = useState(false);
  final filePath = useState<String?>(null);
  final totalPages = useState<int>(0);
  final currentPage = useState<int>(0);
  final controller = useState<PDFViewController?>(null);

  useEffect(
    () {
      Future<void> checkFilePath() async {
        try {
          final valid = await getValidPathFn(ref, previewPath);
          filePath.value = valid;
        } catch (e) {
          hasError.value = true;
        } finally {
          isLoading.value = false;
        }
      }

      checkFilePath();
      return null;
    },
    [previewPath],
  );

  void setTotalPagesFn(int pages) => totalPages.value = pages;
  void setCurrentPageFn(int page) => currentPage.value = page;
  void setControllerFn(PDFViewController c) => controller.value = c;
  void setHasErrorFn(bool value) => hasError.value = value;

  return PdfPreviewData(
    isLoading: isLoading.value,
    hasError: hasError.value,
    filePath: filePath.value,
    totalPages: totalPages.value,
    currentPage: currentPage.value,
    controller: controller.value,
    setTotalPages: setTotalPagesFn,
    setCurrentPage: setCurrentPageFn,
    setHasError: setHasErrorFn,
    setController: setControllerFn,
  );
}

///
/// 필요한 상태들을 묶어 반환하는 클래스
///
class PdfPreviewData {
  final bool isLoading;
  final bool hasError;
  final String? filePath;
  final int totalPages;
  final int currentPage;
  final PDFViewController? controller;

  // 상태 변경 세터
  final void Function(int) setTotalPages;
  final void Function(int) setCurrentPage;
  final void Function(bool) setHasError;
  final void Function(PDFViewController) setController;

  PdfPreviewData({
    required this.isLoading,
    required this.hasError,
    required this.filePath,
    required this.totalPages,
    required this.currentPage,
    required this.controller,
    required this.setTotalPages,
    required this.setCurrentPage,
    required this.setHasError,
    required this.setController,
  });
}
