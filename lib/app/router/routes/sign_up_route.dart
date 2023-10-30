part of '../router.dart';

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
