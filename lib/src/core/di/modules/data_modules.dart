import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/data/firebase/app_fire_storage.dart';
import 'package:techtalk/data/firebase/app_fire_store.dart';
import 'package:techtalk/domain/useCase/chat/get_gpt_reply_use_case_old.dart';

abstract class DataModules {
  DataModules._();

  static void dependencies() {
    locator.registerLazySingleton(() => GetGptReplyUseCase());
    locator.registerSingleton(() => AppFireStore.getInstance);
    locator.registerSingleton(() => AppFireStorage.getInstance);
  }
}
