import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/theme/app_theme.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';

Future<void> runFlavoredApp() async {
  await Flavor.instance.setup();

  return runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: '테크톡',
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      builder: (context, child) {
        AppColor.init(context);

        return child!;
      },
    );
  }
}
