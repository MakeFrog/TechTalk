import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_page.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/profile_setting_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/splash/splash_page.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_page.dart';
import 'package:techtalk/presentation/pages/study/topic_select/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_page.dart';

part 'route_argument.dart';
part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: false,
      navigatorKey: rootNavigatorKey,
      initialLocation: SplashRoute.path,
      // initialLocation: SignInRoute.name,
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
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
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

  static const String path = '/sign_in';
  static const String name = 'sign_in';

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
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
  static const String name = 'sign-up';

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
    TypedGoRoute<InterviewTopicSelectRoute>(
      path: InterviewTopicSelectRoute.name,
      name: InterviewTopicSelectRoute.name,
      routes: [
        TypedGoRoute<QuestionCountSelectPageRoute>(
          path: QuestionCountSelectPageRoute.name,
          name: QuestionCountSelectPageRoute.name,
        ),
      ],
    ),
    TypedGoRoute<ProfileSettingRoute>(
      path: ProfileSettingRoute.name,
      name: ProfileSettingRoute.name,
    ),
    TypedGoRoute<JobGroupSettingRoute>(
      path: JobGroupSettingRoute.name,
      name: JobGroupSettingRoute.name,
    ),
    TypedGoRoute<StudyRoute>(
      path: StudyRoute.path,
      name: StudyRoute.name,
    ),
    TypedGoRoute<WrongAnswerRoute>(
      path: WrongAnswerRoute.name,
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

  static const String name = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainPage();
  }
}

class StudyRoute extends GoRouteData {
  const StudyRoute(this.topicId);

  final String topicId;

  static const String path = ':topicId';
  static const String name = 'study';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProviderScope(
      overrides: [
        selectedStudyTopicProvider.overrideWithValue(
          getTopicUseCase(topicId).getOrThrow(),
        ),
      ],
      child: StudyLearningPage(),
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

class InterviewTopicSelectRoute extends GoRouteData {
  const InterviewTopicSelectRoute();

  static const String name = 'topic-select';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InterviewTopicSelectPage();
  }
}

class QuestionCountSelectPageRoute extends GoRouteData {
  const QuestionCountSelectPageRoute({
    required this.$extra,
  });

  static const String name = 'question-count-select';

  final TopicEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QuestionCountSelectPage(
      topic: $extra,
    );
  }
}

class ProfileSettingRoute extends GoRouteData {
  ProfileSettingRoute(this.$extra);

  static const String name = 'profile-setting';

  final UserDataEntity $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileSettingPage();
  }
}

class JobGroupSettingRoute extends GoRouteData {
  static const String name = 'job_group_setting';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JobGroupSettingPage();
  }
}

class ChatListPageRoute extends GoRouteData {
  const ChatListPageRoute(this.topicId);

  static const String path = 'chat-list/:topicId';
  static const String name = 'chat-list';

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
