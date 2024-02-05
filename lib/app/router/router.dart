import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_page.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/profile_setting_page.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/skill_setting_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/splash/splash_page.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_page.dart';

part 'router.g.dart';

///
/// 부모 라우트가 [$extra]로 argument를 전달하고 있고
/// 자식 라우트도 동일하게 [$extra]로 argument을 전달하는 상황일 때
/// 부모 [$extra]값이 자식[$extra]를 덮어쓰는 고질적인 이슈가 존재.
///
/// 해당 이슈: https://github.com/flutter/flutter/issues/106121
///
/// 1년 반이 더 지난 이슈지만 Flutter tream에서 해결의지 크게 없어보임.
/// 이를 우회회할 수 있는 방법은 라우트를 부모와 자식으로 구분하지 않는 것인데,
/// 이렇게 되면 route path경로를 유동적으로 설정하지 못한다는 문제점이 발생.
/// 이러한 이유로 [ChatListRoute] 라우트 모듈의 경우 [$extra]를 통해 인자를 전달 받지 않고
/// Route 모듈의 전역변수 값을 외부에서 업데이트하여 필요한 섹션에 인자를 전달하는 중
///
///

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(WidgetRef ref) => GoRouter(
      debugLogDiagnostics: true,
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
    TypedGoRoute<ProfileSettingRoute>(
      path: ProfileSettingRoute.name,
      name: ProfileSettingRoute.name,
    ),
    TypedGoRoute<JobGroupSettingRoute>(
      path: JobGroupSettingRoute.name,
      name: JobGroupSettingRoute.name,
    ),
    TypedGoRoute<SkillSettingRoute>(
      path: SkillSettingRoute.name,
      name: SkillSettingRoute.name,
    ),
    TypedGoRoute<StudyRoute>(
      path: StudyRoute.path,
      name: StudyRoute.name,
    ),
    TypedGoRoute<WrongAnswerRoute>(
      path: WrongAnswerRoute.path,
      name: WrongAnswerRoute.name,
    ),
    TypedGoRoute<ChatListRoute>(
      path: ChatListRoute.path,
      name: ChatListRoute.name,
      routes: [
        /// NOTE
        /// [ChatListRoute] 하위에 있는 라우팅이지만
        /// 중복 $extra 설정이 안되는 이슈가 있어서 하위 라우팅을 설정을 배제
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

  static const String path = 'study/:topicId';
  static const String name = 'study';
  static late TopicEntity arg;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    arg = $extra;
    return const StudyLearningPage();
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
  InterviewTopicSelectRoute(this.type);

  static const String path = 'interview/:type';
  static const String name = 'topic select';
  static late InterviewType arg;

  final InterviewType type;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    arg = type;
    return const InterviewTopicSelectPage();
  }
}

class QuestionCountSelectPageRoute extends GoRouteData {
  QuestionCountSelectPageRoute(
    this.type, {
    required this.$extra,
  }) : topicId = $extra.singleOrNull?.id ?? $extra.map((e) => e.id).toString();

  static const String path = ':topicId';
  static const String name = 'question count select';

  final InterviewType type;
  final String topicId;
  final List<TopicEntity> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QuestionCountSelectPage(
      type: type,
      topics: $extra,
    );
  }
}

class ProfileSettingRoute extends GoRouteData {
  const ProfileSettingRoute();

  static const String name = 'profile-setting';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileSettingPage();
  }
}

class JobGroupSettingRoute extends GoRouteData {
  static const String name = 'job-group-setting';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const JobGroupSettingPage();
  }
}

class SkillSettingRoute extends GoRouteData {
  static const String name = 'skill-setting';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SkillSettingPage();
  }
}

@immutable
class ChatListRoute extends GoRouteData {
  const ChatListRoute(
    this.type, {
    this.topicId,
    this.$extra,
  });

  static const String path = 'chats/:type';
  static const String name = 'chat list';
  static late ChatListRouteArg arg;

  final InterviewType type;
  final List<ChatRoomEntity>? $extra;
  final String? topicId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    arg = (
      topic: StoredTopics.getByIdOrNull(topicId),
      interviewType: type,
      chatRooms: $extra
    );
    return ChatListPage();
  }
}

@immutable
class ChatPageRoute extends GoRouteData {
  const ChatPageRoute({required this.type, required this.roomId});

  static const String path = ':roomId';
  static const String name = 'chat';
  static late ChatRoomEntity arg;

  final InterviewType type;
  final String roomId;

  // @override
  // Widget build(BuildContext context, GoRouterState state) {
  //   return const ChatPage();
  // }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      fullscreenDialog: true,
      transitionsBuilder: (_, animation, __, child) {
        var begin = const Offset(1.0, 0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      child: const ChatPage(),
    );
  }
}
