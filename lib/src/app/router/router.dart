import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/src/presentation/pages/welcome/welcome_page.dart';

part 'router.g.dart';

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: $appRoutes,
);

@TypedGoRoute<HomeRoute>(
  path: '/',
  name: HomeRoute.name,
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String name = 'home';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WelcomePage();
  }
}
