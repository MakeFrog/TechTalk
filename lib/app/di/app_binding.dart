import 'package:techtalk/app/di/modules/auth_di.dart';
import 'package:techtalk/app/di/modules/chat_di.dart';
import 'package:techtalk/app/di/modules/interview_di.dart';
import 'package:techtalk/app/di/modules/job_di.dart';
import 'package:techtalk/app/di/modules/topic_di.dart';
import 'package:techtalk/app/di/modules/user_di.dart';

final class AppBinder {
  AppBinder._();

  /// 'Splash' 단계에서 우선적으로 Binding 해야되는 모듈들은
  /// 아래 메소드에서 처리합
  static void _initTopPriority() {}

  static void init() {
    _initTopPriority();

    for (final di in [
      AuthDependencyInjection(),
      UserDependencyInjection(),
      JobDependencyInjection(),
      ChatDependencyInject(),
      InterviewDependencyInjection(),
      TopicDependencyInjection(),
    ]) {
      di.init();
    }
  }
}
