///
/// 라우팅 인자 값을 전역으로 관리하는 모듈
/// 각 페이지의 route arg provider에 값을 직접적으로 전달.
///

abstract class RouteArgContainer {
  RouteArgContainer._();

  static dynamic arg;

  static update(dynamic passedArg) => arg = passedArg;
}
