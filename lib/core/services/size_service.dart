import 'package:flutter/material.dart';

class AppSize {
  AppSize._();

  late double statusBarHeight; // Safe Area 상단 Inset
  late double bottomInset; // Safe Area 하단 Inset
  late double screenWidth; // 디바이스 넓이
  late double screenHeight; // 디바이스 높이
  late double responsiveBottomInset; // 반응형 하단 Safe Area 하단 Inset

  // 비율로 처리했을 때 높이 넓이. (375 * 812) 기준
  double ratioHeight(double givenHeight) => (givenHeight / 812) * screenHeight;
  double ratioWidth(double givenWidth) => (givenWidth / 375) * screenWidth;

  // 초기화 구문
  void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isTablet = mediaQuery.size.width > 600;
    statusBarHeight = mediaQuery.padding.top;
    bottomInset = mediaQuery.padding.bottom;
    screenWidth = isTablet ? 375 : mediaQuery.size.width;
    screenHeight = isTablet ? 812 : mediaQuery.size.height;
    responsiveBottomInset =
        mediaQuery.padding.bottom == 0 ? 16 : mediaQuery.padding.bottom;
  }

  static final AppSize to = AppSize._();
}
