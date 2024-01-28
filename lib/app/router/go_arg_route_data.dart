import 'package:go_router/go_router.dart';
import 'package:techtalk/app/router/route_arg_container.dart';

///
/// 인자를 전달할 때 사용되는 모듈
/// [GoRouteData]을 상속하며 [RouteArgContainer]의 멤버 변수에 값을 업데이트 함.
///

abstract class GoArgRouteData<T> extends GoRouteData {
  GoArgRouteData() {
    RouteArgContainer.update(passedArg);
  }

  T get passedArg;
}
