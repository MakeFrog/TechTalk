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
import 'package:techtalk/core/services/size_service.dart';
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
  await EasyLocalization.ensureInitialized();

  return runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: EasyLocalization(
        // startLocale: locale,
        supportedLocales: Localization.values.map((e) => e.locale).toList(),
        path: 'assets/translations',
        fallbackLocale: Localization.en.locale,
        child: App(),
      ),
    ),
  );
}

class App extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
          AppSize.to.init(context);
          return FToastBuilder()(
            context,
            ResponsiveLayoutBuilder(context, child),
          );
        },
      ),
    );
  }
}
