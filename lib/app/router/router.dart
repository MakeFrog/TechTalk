import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/welcome/welcome_page.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  initialLocation: FirebaseAuth.instance.currentUser == null ? '/welcome' : '/',
  routes: $appRoutes,
);

@TypedGoRoute<WelcomeRoute>(
  path: '/welcome',
  name: WelcomeRoute.name,
)
class WelcomeRoute extends GoRouteData {
  const WelcomeRoute();

  static const String name = 'welcome';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WelcomePage();
  }
}

@TypedGoRoute<SignUpRoute>(
  path: SignUpRoute.path,
  name: SignUpRoute.path,
)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const String path = '/sign-up';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }
}

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
