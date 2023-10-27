import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      initialLocation: !ref.read(isUserAuthorizedProvider)
          ? SignInRoute.name
          : MainRoute.name,
      routes: $appRoutes,
    );

///
/// Sign In Route
///
@TypedGoRoute<SignInRoute>(
  path: SignInRoute.name,
  name: SignInRoute.name,
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  static const String name = '/sign_in';
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

///
/// Sign Up Route
///
@TypedGoRoute<SignUpRoute>(
  path: SignUpRoute.name,
  name: SignUpRoute.name,
)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const String name = '/sign-up';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }
}

///
/// Main Route
///
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
    return InterviewTopicSelectPage();
  }
}
