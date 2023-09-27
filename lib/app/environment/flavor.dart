import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/core/di/app_binding.dart';

class Flavor {
  Flavor._();

  static final Flavor _instance = Flavor._();
  static late Environment _env;

  static Flavor get instance => _instance;
  static Environment get env => _env;

  static void initialize(Environment type) {
    _env = type;
  }

  /// [env]에 따라 어플리케이션 초기 설정을 진행한다.
  Future<void> setup() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(
      fileName: env.dotFileName,
    );

    AppBinding.dependencies();

    final option = env.firebaseOption;

    /// FireBase 초기화
    await Firebase.initializeApp(
      name: option.projectId,
      options: option,
    );
  }
}
