import 'package:flutter/material.dart';
import 'package:techtalk/_backup/app/resources/ui_config/size_config.dart';
import 'package:techtalk/_backup/app/routes/app_pages.dart';
import 'package:techtalk/_backup/presentation/screens/responsive_layout_builder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '테크톡',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        SizeConfig.to.init(context);
        return ResponsiveLayoutBuilder(context, child);
      },
      routerConfig: AppPages.router,
    );
  }
}
