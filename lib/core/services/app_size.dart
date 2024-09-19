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
  static bool _isInitialized = false; // 초기화 상태 확인 변수
  // 비율로 처리했을 때 높이 넓이. (375 * 812) 기준
  static double ratioHeight(double givenHeight) =>
      (givenHeight / 812) * screenHeight;

  static double ratioWidth(double givenWidth) =>
      (givenWidth / 375) * screenWidth;

  // 초기화 구문
  static void init(BuildContext context) async {
    if (_isInitialized) return;
    final bool isTablet = MediaQuery.sizeOf(context).width > 600;
    statusBarHeight = MediaQuery.paddingOf(context).top;
    bottomInset = MediaQuery.paddingOf(context).bottom;
    screenWidth = isTablet ? 375 : MediaQuery.sizeOf(context).width;
    screenHeight = isTablet ? 812 : MediaQuery.sizeOf(context).height;
    responsiveBottomInset = MediaQuery.paddingOf(context).bottom == 0
        ? 16
        : MediaQuery.paddingOf(context).bottom;
    _isInitialized = true;
  }
}
