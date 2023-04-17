import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:moon_dap/app/routes/app_pages.dart';
import 'package:moon_dap/domain/repository/sample_reposiotry.dart';
import 'package:moon_dap/domain/useCase/sample_use_case.dart';
import 'package:moon_dap/presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setup();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

void setup() {
  // getIt.registerLazySingleton<SampleRepository>(() => SampleRepository());
  // getIt.registerLazySingleton<SampleUseCase>(
  //         () => SampleUseCase(getIt.get<SampleRepository>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '문답',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppPages.router,
    );
  }
}
