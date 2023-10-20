part of '../router.dart';

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
