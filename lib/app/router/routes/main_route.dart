part of '../router.dart';

@TypedGoRoute<MainRoute>(
  path: MainRoute.name,
  name: MainRoute.name,
  routes: [
    TypedGoRoute<HomeTopicSelectRoute>(
      path: HomeTopicSelectRoute.name,
      name: HomeTopicSelectRoute.name,
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  static const String name = '/';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MainPage();
  }
}

class HomeTopicSelectRoute extends GoRouteData {
  const HomeTopicSelectRoute();

  static const String name = 'topic-select';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TopicSelectPage();
  }
}
