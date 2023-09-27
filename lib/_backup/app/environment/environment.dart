import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:techtalk/_backup/app/di/app_binding.dart';
import 'package:techtalk/_backup/app/environment/app.dart';
import 'package:techtalk/_backup/app/environment/environment_type.enum.dart';
import 'package:techtalk/app/environment/firebase/firebase_options.dart'
    as prod;
import 'package:techtalk/app/environment/firebase/firebase_options_dev.dart'
    as dev;

final getIt = GetIt.instance;

class Environment {
  static late Environment _instance;
  static late EnvironmentType _type;

  factory Environment.init(EnvironmentType type) {
    _type = type;
    _instance = const Environment._internal();
    return _instance;
  }

  const Environment._internal();

  Future<void> run() async {
    await initialSetup();
    return runApp(const MyApp());
  }

  static Environment get instance => _instance;

  static EnvironmentType get enviroment => _type;
}

Future<void> initialSetup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  AppBinding.dependencies();

  final option = await _getFirebaseOption();

  print(option.projectId);

  /// FireBase 초기화
  await Firebase.initializeApp(
    name: option.projectId,
    options: option,
  );
}

Future<FirebaseOptions> _getFirebaseOption() async {
  PackageInfo package = await PackageInfo.fromPlatform();
  const String name = "com.techtalk";

  print("제공 : ${package.packageName}");

  return switch (package.packageName) {
    name => prod.DefaultFirebaseOptions.currentPlatform,
    "$name.dev" => dev.DefaultFirebaseOptions.currentPlatform,
    _ => throw UnimplementedError(),
  };
}
