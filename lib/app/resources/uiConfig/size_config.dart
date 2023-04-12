import 'package:flutter/material.dart';

/// Created By Ximya 2022.11.04
///  - 앱에서 필요한 [MediaQuery] 인스턴들을 초기화하고 필요한 데이터 생성하는 모듈
///  - 중복된 Mediquery 인스턴스 생성을 방지할 수 있는 이점 있음.
///  - [myApp.dart] 에서 초기화함.
///

class SizeConfig {
  SizeConfig._();

  late double statusBarHeight; // Safe Area 상단 Inset
  late double bottomInset; // Safe Area 하단 Inset
  late double screenWidth; // 디바이스 넓이
  late double screenHeight; // 디바이스 높이
  late double responsiveBottomInset; // 반응형 하단 Safe Area 하단 Inset

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

  static final SizeConfig to = SizeConfig._();
}
