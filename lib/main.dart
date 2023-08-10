// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get_it/get_it.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:techtalk/app/resources/ui_config/size_config.dart';
// import 'package:techtalk/app/routes/app_pages.dart';
// import 'package:techtalk/domain/useCase/chat/get_gpt_reply_use_case_old.dart';
// import 'package:techtalk/presentation/screens/responsive_layout_builder.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   setUp();
//   await initializeDateFormatting().then((_) => runApp(MyApp()));
// }
//
// final getIt = GetIt.instance;
//
// void setUp() {
//   getIt.registerLazySingleton(() => GetGptReplyUseCase());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: '테크톡',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       builder: (context, child) {
//         SizeConfig.to.init(context);
//         return ResponsiveLayoutBuilder(context, child);
//       },
//       routerConfig: AppPages.router,
//     );
//   }
// }
