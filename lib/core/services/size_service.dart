import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:techtalk/features/system/system.dart';

class AppSize {
  AppSize._();

  late double statusBarHeight; // Safe Area 상단 Inset
  late double bottomInset; // Safe Area 하단 Inset
  late double screenWidth; // 디바이스 넓이
  late double screenHeight; // 디바이스 높이
  late double responsiveBottomInset; // 반응형 하단 Safe Area 하단 Inset
  double? keyboardHeight;

  // 비율로 처리했을 때 높이 넓이. (375 * 812) 기준
  double ratioHeight(double givenHeight) => (givenHeight / 812) * screenHeight;

  double ratioWidth(double givenWidth) => (givenWidth / 375) * screenWidth;

  // 초기화 구문
  void init(BuildContext context) async {
    final mediaQuery = MediaQuery.of(context);
    final bool isTablet = mediaQuery.size.width > 600;
    statusBarHeight = mediaQuery.padding.top;
    bottomInset = mediaQuery.padding.bottom;
    screenWidth = isTablet ? 375 : mediaQuery.size.width;
    screenHeight = isTablet ? 812 : mediaQuery.size.height;
    responsiveBottomInset =
        mediaQuery.padding.bottom == 0 ? 16 : mediaQuery.padding.bottom;

    await setKeyboardHeightFromCache();
  }

  static final AppSize to = AppSize._();

  Future<void> updateKeyboardHeight(double height) async {
    final response = await systemRepository.storeKeyboardHeight(height);
    response.fold(
      onSuccess: (_) {
        keyboardHeight = height;
      },
      onFailure: (e) {
        log('AppSize : 키보드 높이를 업데이트 하지 못함 : $e');
        throw e;
      },
    );
  }

  /// 로컬에 저장된 키보드 높이 값을 기반으로 필요한 값을 초기화
  Future<void> setKeyboardHeightFromCache() async {
    if (keyboardHeight != null && keyboardHeight! >= 150) return;

    final response = await systemRepository.getKeyboardHeight();
    response.fold(
      onSuccess: (height) {
        if (height == null) return;
        keyboardHeight = height;
      },
      onFailure: (e) {
        log('AppSize : 저장된 키보드 높이를 불러오지 못함 : $e');
        throw e;
      },
    );
  }
}
