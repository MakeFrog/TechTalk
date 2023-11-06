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
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  initialLocation: SplashRoute.name,
  routes: $appRoutes,
);

///
/// splash
///
@TypedGoRoute<SplashRoute>(
  path: SplashRoute.name,
  name: SplashRoute.name,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const String name = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplashPage();
  }
}

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
    TypedGoRoute<StudyRoute>(
      path: StudyRoute.name,
      name: StudyRoute.name,
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

class StudyRoute extends GoRouteData {
  const StudyRoute(this.topicName);

  final String topicName;
  static const String name = 'study';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Consumer(
      builder: (context, ref, child) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ref
              .read(selectedStudyTopicProvider.notifier)
              .setTopicByName(topicName);
        });

        return StudyPage();
      },
    );
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
