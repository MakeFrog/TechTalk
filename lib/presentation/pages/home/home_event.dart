import 'package:techtalk/app/router/router.dart';

abstract interface class _HomeEvent {
  void onTapNewTopicInterview();
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapNewTopicInterview() {
    const HomeTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }
}
