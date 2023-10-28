import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/home/home_page.dart';
import 'package:techtalk/core/utils/route_argument.dart';
import 'package:techtalk/presentation/pages/chat/chat_page.dart';
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
          : HomeRoute.name,
      routes: $appRoutes,
    );

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
  path: HomeRoute.name,
  name: HomeRoute.name,
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const String name = '/';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomePage();
  }
}

@TypedGoRoute<ChatPageRoute>(path: ChatPageRoute.name, name: ChatPageRoute.name)
class ChatPageRoute extends GoRouteData {
  const ChatPageRoute();

  static const String name = '/chat';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    RouteArg.update(state.extra ?? 'ASDKJF32STSS3A');
    return const ChatPage();
  }
}
