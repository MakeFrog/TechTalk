import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum PreviewMode {
  none, // path == null
  network, // URL
  local, // 로컬 PDF
}

class PdfPreviewNotifier extends ChangeNotifier {
  bool _isProcessingPath = false; // 경로 확인했는가?
  PreviewMode _mode = PreviewMode.none;
  String? _filePath;
  PDFViewController? _pdfController;
  int _totalPages = 0;
  int _currentPage = 0;
  WebViewController? _webViewController;
  int _webViewProgress = 0; // 0 ~ 100

  /// GETTER
  bool get isProcessingPath => _isProcessingPath;
  PreviewMode get mode => _mode;
  String? get filePath => _filePath;
  PDFViewController? get pdfController => _pdfController;
  int get totalPages => _totalPages;
  int get currentPage => _currentPage;
  WebViewController? get webViewController => _webViewController;
  int get webViewProgress => _webViewProgress;
  bool get isWebViewLoading =>
      (webViewProgress < 100) && _mode == PreviewMode.network;

  /// 이력서 저장 경로별 분기처리 로직
  Future<void> setPreviewPath(String? path) async {
    try {
      _mode = PreviewMode.none;
      _filePath = null;
      _pdfController = null;
      _totalPages = 0;
      _currentPage = 0;
      _webViewController = null;
      _webViewProgress = 0;

      // 경로가 없으면 (null or empty)
      if (path == null || path.isEmpty) {
        _mode = PreviewMode.none;
        await EasyLoading.dismiss();
        return;
      }

      // 경로가 URL일 때
      if (path.toLowerCase().startsWith('http')) {
        _mode = PreviewMode.network;
        await _initWebView(path);
      } 
      // 경로가 로컬일 때
      else {
        _mode = PreviewMode.local;
        await _loadLocalPdf(path);
      }
    } catch (e) {
      await EasyLoading.dismiss();
      await EasyLoading.showError('파일 로딩 실패: $e');
    } finally {
      // 로딩 끝
      _isProcessingPath = false;
      await EasyLoading.dismiss();
      notifyListeners();
    }
  }

  /// 경로가 URL일 때 로직
  Future<void> _initWebView(String url) async {
    final controller = WebViewController();

    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          EasyLoading.show(status: '웹뷰 로딩중...');
        },
        onPageFinished: (url) {
          EasyLoading.dismiss();
        },
        onWebResourceError: (error) {
          EasyLoading.showError('웹뷰 로딩 에러: $error');
        },
      ),
    );

    // 웹페이지 불러오기
    await controller.loadRequest(Uri.parse(url));

    _webViewController = controller;
    await EasyLoading.dismiss();
  }

  /// 경로가 로컬일 때 로직
  Future<void> _loadLocalPdf(String path) async {
    await EasyLoading.show(status: 'PDF 파일 확인중...');

    final validPath = await _getValidPath(path);
    _filePath = validPath;

    await EasyLoading.dismiss();
  }

  /// 로컬 경로가 유효한지 확인
  Future<String> _getValidPath(String storedPath) async {
    final f = File(storedPath);
    if (f.existsSync()) {
      return storedPath;
    }

    final docDir = await getApplicationDocumentsDirectory();
    final fallback = p.join(docDir.path, p.basename(storedPath));
    final fallbackFile = File(fallback);
    if (fallbackFile.existsSync()) {
      return fallback;
    }

    throw Exception('파일이 존재하지 않습니다.');
  }

  /// PDFView 콜백
  void setPdfController(PDFViewController controller) {
    _pdfController = controller;
    notifyListeners();
  }

  void setTotalPages(int pages) {
    _totalPages = pages;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}

/// PROVIDER
final pdfPreviewNotifierProvider =
    ChangeNotifierProvider.autoDispose<PdfPreviewNotifier>(
  (ref) => PdfPreviewNotifier(),
);
