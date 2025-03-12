import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/foundation.dart'; // for ChangeNotifier
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PdfPreviewNotifier extends ChangeNotifier {
  bool _isLoading = true;
  bool _hasError = false;
  String? _filePath;
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _controller;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String? get filePath => _filePath;
  int get totalPages => _totalPages;
  int get currentPage => _currentPage;
  PDFViewController? get controller => _controller;

  ///
  /// 파일 경로를 받아서 로드하고, 필요하면 상태 변경
  ///
  Future<void> loadFile(String previewPath) async {
    // 이전 상태 초기화
    _filePath = null;
    _controller = null;
    _totalPages = 0;
    _currentPage = 0;

    try {
      _isLoading = true;
      _hasError = false;
      notifyListeners();

      final valid = await _getValidPath(previewPath);
      _filePath = valid;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setTotalPages(int pages) {
    _totalPages = pages;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void setHasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setController(PDFViewController c) {
    _controller = c;
    notifyListeners();
  }

  ///
  /// 파일 상대 경로 -> 절대 경로로 변환
  ///
  Future<String> _getValidPath(String storedPath) async {
    final storedFile = File(storedPath);
    if (storedFile.existsSync()) {
      return storedPath;
    }

    final docDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(storedPath);
    final fallbackPath = p.join(docDir.path, fileName);
    final fallbackFile = File(fallbackPath);

    if (fallbackFile.existsSync()) {
      return fallbackPath;
    }
    throw Exception('파일을 찾을 수 없습니다.');
  }
}

/// PROVIDER
final pdfPreviewNotifierProvider =
    ChangeNotifierProvider.autoDispose<PdfPreviewNotifier>((ref) {
  return PdfPreviewNotifier();
});
