import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:techtalk/features/system/system.dart';

class AppSize {
  AppSize._();

  static late double statusBarHeight; // Safe Area 상단 Inset
  static late double bottomInset; // Safe Area 하단 Inset
  static late double screenWidth; // 디바이스 넓이
  static late double screenHeight; // 디바이스 높이
  static late double responsiveBottomInset; // 반응형 하단 Safe Area 하단 Inset
  static double? keyboardHeight;

  // 비율로 처리했을 때 높이 넓이. (375 * 812) 기준
  static double ratioHeight(double givenHeight) =>
      (givenHeight / 812) * screenHeight;

  static double ratioWidth(double givenWidth) =>
      (givenWidth / 375) * screenWidth;

  // 초기화 구문
  static void init(BuildContext context) async {
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    statusBarHeight = MediaQuery.paddingOf(context).top;
    bottomInset = MediaQuery.paddingOf(context).bottom;
    screenWidth = isTablet ? 375 : MediaQuery.sizeOf(context).width;
    screenHeight = isTablet ? 812 : MediaQuery.sizeOf(context).height;
    responsiveBottomInset = MediaQuery.paddingOf(context).bottom == 0
        ? 16
        : MediaQuery.paddingOf(context).bottom;

    await setKeyboardHeightFromCache();
  }

  static Future<void> updateKeyboardHeight(double height) async {
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
  static Future<void> setKeyboardHeightFromCache() async {
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
