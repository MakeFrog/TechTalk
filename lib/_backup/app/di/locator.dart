import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;

// 안전하게 등록된 인스턴스를 해제하는 메소드
void safeUnregister<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

// 안전하게 Factory 인스턴스를 등록하는 메소드
void safeRegisterFactory<T extends Object>(FactoryFunc<T> factoryFunc) {
  if (!locator.isRegistered<T>()) {
    locator.registerFactory<T>(factoryFunc);
  }
}