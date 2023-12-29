// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $signInRoute,
      $signUpRoute,
      $mainRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      name: 'splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute => GoRouteData.$route(
      path: '/sign_in',
      name: 'sign_in',
      factory: $SignInRouteExtension._fromState,
    );

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location(
        '/sign_in',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
      path: '/sign-up',
      name: 'sign-up',
      factory: $SignUpRouteExtension._fromState,
    );

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  String get location => GoRouteData.$location(
        '/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainRoute => GoRouteData.$route(
      path: '/',
      name: '/',
      factory: $MainRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'topic-select',
          name: 'topic-select',
          factory: $InterviewTopicSelectRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'question-count-select',
              name: 'question-count-select',
              factory: $QuestionCountSelectPageRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'profile-setting',
          name: 'profile-setting',
          factory: $ProfileSettingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: ':topicId',
          name: 'study',
          factory: $StudyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'wrong-answer',
          name: 'wrong-answer',
          factory: $WrongAnswerRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'chat-list/:topicId',
          name: 'chat-list',
          factory: $ChatListPageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':roomId',
              name: 'chat',
              factory: $ChatPageRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InterviewTopicSelectRouteExtension on InterviewTopicSelectRoute {
  static InterviewTopicSelectRoute _fromState(GoRouterState state) =>
      const InterviewTopicSelectRoute();

  String get location => GoRouteData.$location(
        '/topic-select',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QuestionCountSelectPageRouteExtension
    on QuestionCountSelectPageRoute {
  static QuestionCountSelectPageRoute _fromState(GoRouterState state) =>
      QuestionCountSelectPageRoute(
        $extra: state.extra as TopicEntity,
      );

  String get location => GoRouteData.$location(
        '/topic-select/question-count-select',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ProfileSettingRouteExtension on ProfileSettingRoute {
  static ProfileSettingRoute _fromState(GoRouterState state) =>
      ProfileSettingRoute(
        state.extra as UserDataEntity,
      );

  String get location => GoRouteData.$location(
        '/profile-setting',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $StudyRouteExtension on StudyRoute {
  static StudyRoute _fromState(GoRouterState state) => StudyRoute(
        state.pathParameters['topicId']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(topicId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WrongAnswerRouteExtension on WrongAnswerRoute {
  static WrongAnswerRoute _fromState(GoRouterState state) => WrongAnswerRoute(
        $extra: state.extra as int?,
      );

  String get location => GoRouteData.$location(
        '/wrong-answer',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ChatListPageRouteExtension on ChatListPageRoute {
  static ChatListPageRoute _fromState(GoRouterState state) => ChatListPageRoute(
        state.pathParameters['topicId']!,
      );

  String get location => GoRouteData.$location(
        '/chat-list/${Uri.encodeComponent(topicId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        state.extra as ChatRoomEntity,
      );

  String get location => GoRouteData.$location(
        '/chat-list/${Uri.encodeComponent(topicId)}/${Uri.encodeComponent(roomId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
