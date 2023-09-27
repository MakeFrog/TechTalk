import 'package:techtalk/_backup/app/di/modules/data_modules.dart';
import 'package:techtalk/_backup/app/di/modules/domain_modules.dart';

abstract class AppBinding {
  AppBinding._();

  /// 'Splash' 단계에서 우선적으로 Binding 해야되는 모듈들은
  /// 아래 메소드에서 처리합
  static void _initialBinding() {}

  static void dependencies() {
    _initialBinding();
    DomainModules.dependencies();
    DataModules.dependencies();
  }
}
