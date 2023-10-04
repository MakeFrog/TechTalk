import 'package:get_it/get_it.dart';
import 'package:techtalk/features/sign_up/data/sign_up_db.dart';

abstract class SignUpDependencyInjection {
  static void init() {
    final locator = GetIt.I;

    locator.registerLazySingleton(SignUpDB.new);
  }
}
