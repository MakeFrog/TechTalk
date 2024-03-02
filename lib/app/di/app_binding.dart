import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/modules/auth_di.dart';
import 'package:techtalk/app/di/modules/chat_di.dart';
import 'package:techtalk/app/di/modules/system_di.dart';
import 'package:techtalk/app/di/modules/tech_set_di.dart';
import 'package:techtalk/app/di/modules/topic_di.dart';
import 'package:techtalk/app/di/modules/user_di.dart';
import 'package:techtalk/app/di/modules/wrong_answer_note_di.dart';

final locator = GetIt.I;

// 안전하게 등록된 인스턴스를 해제하는 메소드
void safeUnregister<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

// 안전하게 Factory 싱글톤 등록하는 메소드
void safeRegisterSingleton<T extends Object>(FactoryFunc<T> factoryFunc) {
  if (!locator.isRegistered<T>()) {
    locator.registerLazySingleton<T>(factoryFunc);
  }
}

final class AppBinder {
  AppBinder._();

  /// 'Splash' 단계에서 우선적으로 Binding 해야되는 모듈들은
  /// 아래 메소드에서 처리합
  static void _initTopPriority() {
    // AppRate.init();
  }

  static Future<void> init() async {
    _initTopPriority();

    for (final di in [
      SystemDependencyInjection(),
      AuthDependencyInjection(),
      UserDependencyInjection(),
      JobDependencyInjection(),
      ChatDependencyInject(),
      WrongAnswerNoteDependencyInjection(),
      TopicDependencyInjection(),
    ]) {
      di.init();
    }
  }
}
