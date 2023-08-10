import 'package:flutter/material.dart';
import 'package:techtalk/app/environment/app.dart';
import 'package:techtalk/app/environment/environment_type.enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:techtalk/domain/useCase/chat/get_gpt_reply_use_case_old.dart';

final getIt = GetIt.instance;

void setBindings() {
  getIt.registerLazySingleton(() => GetGptReplyUseCase());
}

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
  await dotenv.load(fileName: ".env");
  setBindings();
}
