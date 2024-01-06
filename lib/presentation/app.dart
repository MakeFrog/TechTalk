import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/app_theme.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';

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
            child,
          );
        },
      ),
    );
  }
}
