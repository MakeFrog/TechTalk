import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/core/modules/local/app_local.dart';

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

    // 환경 파일 로드
    await dotenv.load(
      fileName: env.dotFileName,
    );

    final option = env.firebaseOption;

    /// LocalStorage Hive 초기화
    await AppLocal.initHive();

    /// FireBase 초기화
    await Firebase.initializeApp(
      options: option,
    );

    /// 앱 DI 실행
    await AppBinder.init();

    await EasyLocalization.ensureInitialized();

    await FirebaseAnalytics.instance
        .setAnalyticsCollectionEnabled(_env == Environment.prod ? true : false);
    if (_env == Environment.prod) {
      await FirebaseAnalytics.instance.logAppOpen();
    }
  }
}
