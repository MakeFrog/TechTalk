import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/splash/splash_page.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_page.dart';
import 'package:techtalk/presentation/pages/study/topic_select/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_page.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: false,
      navigatorKey: rootNavigatorKey,
      initialLocation: SplashRoute.path,
      routes: $appRoutes,
    );

///
/// splash
///
@TypedGoRoute<SplashRoute>(
  path: SplashRoute.path,
  name: SplashRoute.name,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const String path = '/splash';
  static const String name = 'splash';

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(secondaryAnimation),
          child: child,
        );
      },
      child: const SplashPage(),
    );
  }
}

///
/// Sign In Route
///
@TypedGoRoute<SignInRoute>(
  path: SignInRoute.path,
  name: SignInRoute.name,
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  static const String path = '/sign-in';
  static const String name = 'sign in';

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
          child: child,
        );
      },
      child: SignInPage(),
    );
  }
}

///
/// Sign Up Route
///
@TypedGoRoute<SignUpRoute>(
  path: SignUpRoute.path,
  name: SignUpRoute.name,
)
class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  static const String path = '/sign-up';
  static const String name = 'sign up';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpPage();
  }
}

///
/// Main Route
///
@TypedGoRoute<MainRoute>(
  path: MainRoute.path,
  name: MainRoute.name,
  routes: [
    TypedGoRoute<InterviewTopicSelectRoute>(
      path: InterviewTopicSelectRoute.path,
      name: InterviewTopicSelectRoute.name,
      routes: [
        TypedGoRoute<QuestionCountSelectPageRoute>(
          path: QuestionCountSelectPageRoute.path,
          name: QuestionCountSelectPageRoute.name,
        ),
      ],
    ),
    TypedGoRoute<StudyRoute>(
      path: StudyRoute.path,
      name: StudyRoute.name,
    ),
    TypedGoRoute<WrongAnswerRoute>(
      path: WrongAnswerRoute.path,
      name: WrongAnswerRoute.name,
    ),
    TypedGoRoute<ChatListPageRoute>(
      path: ChatListPageRoute.path,
      name: ChatListPageRoute.name,
      routes: [
        TypedGoRoute<ChatPageRoute>(
          path: ChatPageRoute.path,
          name: ChatPageRoute.name,
        ),
      ],
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  static const String path = '/';
  static const String name = 'main';

  // @override
  // Widget build(BuildContext context, GoRouterState state) {
  //   return const MainPage();
  // }

  @override
  Page<Function> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
          child: child,
        );
      },
      child: MainPage(),
    );
  }
}

class StudyRoute extends GoRouteData {
  StudyRoute(this.$extra) : topicId = $extra.id;

  final String topicId;
  final TopicEntity $extra;

  static const String path = ':topicId';
  static const String name = 'study';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        selectedStudyTopicProvider.overrideWithValue($extra),
      ],
      child: const StudyLearningPage(),
    );
  }
}

class WrongAnswerRoute extends GoRouteData {
  const WrongAnswerRoute(this.$extra);

  final int? $extra;
  static const String path = 'wrong-answer';
  static const String name = 'wrong answer';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReviewNoteDetailPage(page: $extra ?? 0);
  }
}

class InterviewTopicSelectRoute extends GoRouteData {
  const InterviewTopicSelectRoute(this.type);

  static const String path = ':type';
  static const String name = 'topic select';

  final InterviewType type;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InterviewTopicSelectPage(
      type: type,
    );
  }
}

class QuestionCountSelectPageRoute extends GoRouteData {
  QuestionCountSelectPageRoute(
    this.type, {
    required this.$extra,
  }) : _topicId = $extra.singleOrNull?.id ?? $extra.map((e) => e.id).toString();

  static const String path = ':_topicId';
  static const String name = 'question count select';

  final InterviewType type;
  final String _topicId;
  final List<TopicEntity> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QuestionCountSelectPage(
      topic: $extra.first,
    );
  }
}

class ChatListPageRoute extends GoRouteData {
  const ChatListPageRoute(this.topicId);

  static const String path = 'chat-list/:topicId';
  static const String name = 'chat list';

  final String topicId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        selectedInterviewTopicProvider.overrideWithValue(
          getTopicUseCase(topicId).getOrThrow(),
        ),
      ],
      child: ChatListPage(
        topicId: topicId,
      ),
    );
  }
}

class ChatPageRoute extends GoRouteData {
  ChatPageRoute(this.$extra)
      : topicId = $extra.topic.id,
        roomId = $extra.id;

  static const String path = ':roomId';
  static const String name = 'chat';

  final String topicId;
  final String roomId;
  final ChatRoomEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        selectedChatRoomProvider.overrideWith((ref) => $extra),
      ],
      child: const ChatPage(),
    );
  }
}
