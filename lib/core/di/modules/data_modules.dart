import 'package:get_it/get_it.dart';
import 'package:techtalk/_backup/data/firebase/app_fire_storage.dart';
import 'package:techtalk/_backup/data/firebase/app_fire_store.dart';
import 'package:techtalk/_backup/domain/useCase/chat/get_gpt_reply_use_case_old.dart';

abstract class DataModules {
  static void dependencies() {
    GetIt.I.registerLazySingleton(() => GetGptReplyUseCase());
    GetIt.I.registerSingleton(() => AppFireStore.getInstance);
    GetIt.I.registerSingleton(() => AppFireStorage.getInstance);
  }
}
