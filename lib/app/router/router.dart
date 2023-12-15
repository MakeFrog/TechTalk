import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_progress_state.enum.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_page_route_argument_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/provider/question_count_select_page_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/questino_count_select/question_count_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/splash/splash_page.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_page.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';

part 'route_argument.dart';
part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: false,
      navigatorKey: rootNavigatorKey,
      initialLocation: SplashRoute.name,
      // initialLocation: SignInRoute.name,
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
    return const SplashPage();
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
      routes: [
        TypedGoRoute<QuestionCountSelectPageRoute>(
          path: QuestionCountSelectPageRoute.name,
          name: QuestionCountSelectPageRoute.name,
        ),
      ],
    ),
    TypedGoRoute<StudyRoute>(
      path: StudyRoute.name,
      name: StudyRoute.name,
    ),
    TypedGoRoute<WrongAnswerRoute>(
      path: WrongAnswerRoute.name,
      name: WrongAnswerRoute.name,
    ),
    TypedGoRoute<ChatListPageRoute>(
      path: ChatListPageRoute.name,
      name: ChatListPageRoute.name,
      routes: [
        TypedGoRoute<ChatPageRoute>(
          path: ChatPageRoute.name,
          name: ChatPageRoute.name,
        ),
      ],
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  static const String name = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainPage();
  }
}

class StudyRoute extends GoRouteData {
  const StudyRoute(this.topicId);

  final String topicId;
  static const String name = 'study';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        selectedStudyTopicIdProvider.overrideWithValue(topicId),
      ],
      child: const StudyLearningPage(),
    );
  }
}

class WrongAnswerRoute extends GoRouteData {
  const WrongAnswerRoute({this.$extra});

  final int? $extra;
  static const String name = 'wrong-answer';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ReviewNoteDetailPage(page: $extra ?? 0);
  }
}

class HomeTopicSelectRoute extends GoRouteData {
  const HomeTopicSelectRoute();

  static const String name = 'topic-select';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InterviewTopicSelectPage();
  }
}

class QuestionCountSelectPageRoute extends GoRouteData {
  const QuestionCountSelectPageRoute({required this.selectedTopic});

  final Topic selectedTopic;

  static const String name = 'question-count-select';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        questionCountSelectRouteArgProvider.overrideWithValue(selectedTopic),
      ],
      child: QuestionCountSelectPage(),
    );
  }
}

class ChatListPageRoute extends GoRouteData {
  const ChatListPageRoute();

  static const String name = 'chat-list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatListPage();
  }
}

class ChatPageRoute extends GoRouteData {
  ChatPageRoute({
    required this.progressState,
    required this.$extra,
    required this.roomId,
    required this.topic,
    required this.interviewer,
  });

  static const String name = 'chat';

  final InterviewProgressState progressState;
  final ChatQnaProgressInfoEntity $extra;
  final String roomId;
  final Topic topic;
  final InterviewerAvatar interviewer;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final ChatPageRouteArg arg = (
      progressState: progressState,
      qnaProgressInfo: $extra,
      roomId: roomId,
      topic: topic,
      interviewer: interviewer,
    );

    return ProviderScope(
      overrides: [chatPageRouteArgProvider.overrideWithValue(arg)],
      child: const ChatPage(),
    );
  }
}
