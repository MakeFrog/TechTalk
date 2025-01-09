import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dart_openai/dart_openai.dart' as forWhisper;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/environment/environment.enum.dart';
import 'package:techtalk/app/notification/app_local_notification.dart';
import 'package:techtalk/core/modules/device/app_device.dart';
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

    final rootIsolateToken = RootIsolateToken.instance;
    if (rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    }

    // 환경 파일 로드
    await dotenv.load(
      fileName: env.dotFileName,
    );

    final option = env.firebaseOption;

    /// LocalStorage Hive 초기화
    await AppLocal.initHive();
    // AppLocal.clearAllLocalStorage();

    /// FireBase 초기화
    await Firebase.initializeApp(
      options: option,
    );

    FirebaseMessaging.onBackgroundMessage((_) async {});

    try {
      await AppDevice.init();
    } catch (e) {
      log('디바이스 정보 호출 실패 :$e');
    }

    try {
      await AppLocalNotification().initialize();
    } catch (e) {
      print('Local Notification 초기화 실패 :$e');
    }

    OpenAI.instance.build(
      token: env.openApiKey,
      baseOption: HttpSetup(
          receiveTimeout: const Duration(seconds: 10),
          connectTimeout: const Duration(seconds: 10)),
      enableLog: true,
    );

    /// 채팅 면접에서 사용되는 OepnAI SK
    OpenAI.instance.build(
      token: env.openApiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
      ),
      enableLog: true,
    );

    /// whisper 모델을 제공하는 OpenAI SDK
    forWhisper.OpenAI.apiKey = env.openApiKey;
    forWhisper.OpenAI.requestsTimeOut = const Duration(seconds: 60);

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
