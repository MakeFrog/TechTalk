import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/utils/route_argument.dart';
import 'package:techtalk/features/chat/enums/interview_progress_state.enum.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';
import 'package:techtalk/presentation/pages/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/home/home_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/test_page/test_page.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

void routeBack() {
  rootNavigatorKey.currentContext!.pop();
}

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      initialLocation: !ref.read(isUserAuthorizedProvider)
          ? TestPageRoute.name
          : TestPageRoute.name,
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

typedef ChatPageRouteArg = ({
  InterviewProgressState progressState,
  String? roomId,
  InterviewTopic topic
});

@TypedGoRoute<ChatPageRoute>(path: ChatPageRoute.name, name: ChatPageRoute.name)
class ChatPageRoute extends GoRouteData {
  const ChatPageRoute(
      {required this.progressState, required this.roomId, required this.topic});

  static const String name = '/chat';

  final InterviewProgressState progressState;
  final String? roomId;
  final InterviewTopic topic;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final ChatPageRouteArg arg =
        (progressState: progressState, roomId: roomId, topic: topic);

    RouteArg.update(arg);

    return const ChatPage();
  }
}

@TypedGoRoute<TestPageRoute>(path: TestPageRoute.name, name: TestPageRoute.name)
class TestPageRoute extends GoRouteData {
  const TestPageRoute();

  static const String name = '/test';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TestPage();
  }
}
