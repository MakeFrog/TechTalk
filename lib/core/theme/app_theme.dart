import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

part 'components/app_bar_theme.dart';
part 'components/filled_button_theme.dart';
part 'components/input_decoration_theme.dart';
part 'components/outlined_button_theme.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    splashFactory: NoSplash.splashFactory,
    textTheme: ThemeData().textTheme.apply(
          fontFamily: 'pretendard',
          bodyColor: AppColor().black,
          displayColor: AppColor().black,
        ),

    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: AppColor().brand2),
    filledButtonTheme: _FilledButtonTheme.light,
    outlinedButtonTheme: _OutlinedButtonTheme.light,
    inputDecorationTheme: _InputDecorationTheme.light,

    appBarTheme: _AppBarTheme.light,
    // 플랫폼별 라우팅 애니메이션 속성
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
      },
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppColor(),
    ],
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: ThemeData().textTheme.apply(
          fontFamily: 'pretendard',
          bodyColor: AppColor().black,
          displayColor: AppColor().black,
        ),
    extensions: <ThemeExtension<dynamic>>[
      AppColor.dark(),
    ],
  );
}
