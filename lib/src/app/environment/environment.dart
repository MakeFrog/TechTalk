import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techtalk/src/app/environment/environment_type.enum.dart';
import 'package:techtalk/src/app/environment/firebase/firebase_options.dart'
    as prod;
import 'package:techtalk/src/app/environment/firebase/firebase_options_dev.dart'
    as dev;
import 'package:techtalk/src/core/di/app_binding.dart';

class Environment {
  const Environment._();

  static const Environment _instance = Environment._();
  static EnvironmentType? _type;

  factory Environment.init(EnvironmentType type) {
    _type ??= type;

    return _instance;
  }

  static Environment get instance => _instance;
  static EnvironmentType get type => _type!;

  static Future<void> setup() async {
    if (_type == null) {
      return;
    }

    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    AppBinding.dependencies();

    final option = await _getFirebaseOption();

    /// FireBase 초기화
    await Firebase.initializeApp(
      name: option.projectId,
      options: option,
    );
  }

  static Future<FirebaseOptions> _getFirebaseOption() async {
    return switch (type) {
      EnvironmentType.prod => prod.DefaultFirebaseOptions.currentPlatform,
      EnvironmentType.dev => dev.DefaultFirebaseOptions.currentPlatform,
    };
  }
}
