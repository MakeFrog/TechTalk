import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/app/routes/go_route_with_binding.dart';
import 'package:techtalk/presentation/screens/chat/chat_binding.dart';

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
    return SizedBox();
  }
}
