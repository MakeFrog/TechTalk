import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/app/localization/localization_enum.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_theme.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/presentation/widgets/common/layout/responsive_layout.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{ 
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('${provider.name ?? provider.runtimeType} dispose');
  }
}

Future<void> runFlavoredApp() async {
  await Flavor.instance.setup();

  return runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key}) {
    _initLoadingIndicator();
  }

  static void _initLoadingIndicator() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      // 로딩 인디케이터 배경 색상. 그림자는 사용하지 않아도 될 듯
      ..backgroundColor = Colors.transparent
      ..boxShadow = []
      ..indicatorColor = Colors.white
      // 로딩 인디케이터 호출 시 오베리어 컬러
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.transparent
      ..textColor = Colors.white
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      // 앱 언어만 바꿀 경우 Locale(en-KR)과 같은 형식으로 들어오므로 langCode만 봐야함
      useOnlyLangCode: true,
      startLocale: Localization.getMatchedLocalization(
              View.of(context).platformDispatcher.locale.languageCode)
          .locale,
      fallbackLocale: Localization.en.locale,
      supportedLocales: Localization.values.map((e) => e.locale).toList(),
      path: 'assets/translations',
      child: Consumer(
        builder: (context, ref, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: appRouter(ref),
            debugShowCheckedModeBanner: false,
            title: '테크톡',
            themeMode: ThemeMode.light,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            builder: EasyLoading.init(
              builder: (context, child) {
                AppColor.init(context);
                AppSize.init(context);
                return FToastBuilder()(
                  context,
                  ResponsiveLayoutBuilder(context, child),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
