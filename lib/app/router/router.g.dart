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
      path: '/sign-in',
      name: 'sign in',
      factory: $SignInRouteExtension._fromState,
    );

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location(
        '/sign-in',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
      path: '/sign-up',
      name: 'sign up',
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
      name: 'main',
      factory: $MainRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'interview/:type',
          name: 'topic select',
          factory: $InterviewTopicSelectRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':topicId',
              name: 'question count select',
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
          path: 'job-group-setting',
          name: 'job-group-setting',
          factory: $JobGroupSettingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'skill-setting',
          name: 'skill-setting',
          factory: $SkillSettingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'study/:topicId',
          name: 'study',
          factory: $StudyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'wrong-answer/:index',
          name: 'wrong answer',
          factory: $WrongAnswerRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'chats/:type',
          name: 'chat list',
          factory: $ChatListRouteExtension._fromState,
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
      InterviewTopicSelectRoute(
        _$InterviewTypeEnumMap._$fromName(state.pathParameters['type']!),
      );

  String get location => GoRouteData.$location(
        '/interview/${Uri.encodeComponent(_$InterviewTypeEnumMap[type]!)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$InterviewTypeEnumMap = {
  InterviewType.singleTopic: 'single-topic',
  InterviewType.practical: 'practical',
};

extension $QuestionCountSelectPageRouteExtension
    on QuestionCountSelectPageRoute {
  static QuestionCountSelectPageRoute _fromState(GoRouterState state) =>
      QuestionCountSelectPageRoute(
        _$InterviewTypeEnumMap._$fromName(state.pathParameters['type']!),
        state.pathParameters['topicId']!,
      );

  String get location => GoRouteData.$location(
        '/interview/${Uri.encodeComponent(_$InterviewTypeEnumMap[type]!)}/${Uri.encodeComponent(topicId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileSettingRouteExtension on ProfileSettingRoute {
  static ProfileSettingRoute _fromState(GoRouterState state) =>
      const ProfileSettingRoute();

  String get location => GoRouteData.$location(
        '/profile-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $JobGroupSettingRouteExtension on JobGroupSettingRoute {
  static JobGroupSettingRoute _fromState(GoRouterState state) =>
      JobGroupSettingRoute();

  String get location => GoRouteData.$location(
        '/job-group-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SkillSettingRouteExtension on SkillSettingRoute {
  static SkillSettingRoute _fromState(GoRouterState state) =>
      SkillSettingRoute();

  String get location => GoRouteData.$location(
        '/skill-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StudyRouteExtension on StudyRoute {
  static StudyRoute _fromState(GoRouterState state) => StudyRoute(
        state.extra as TopicEntity,
      );

  String get location => GoRouteData.$location(
        '/study/${Uri.encodeComponent(topicId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $WrongAnswerRouteExtension on WrongAnswerRoute {
  static WrongAnswerRoute _fromState(GoRouterState state) => WrongAnswerRoute(
        int.parse(state.pathParameters['index']!),
      );

  String get location => GoRouteData.$location(
        '/wrong-answer/${Uri.encodeComponent(index.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatListRouteExtension on ChatListRoute {
  static ChatListRoute _fromState(GoRouterState state) => ChatListRoute(
        _$InterviewTypeEnumMap._$fromName(state.pathParameters['type']!),
        topicId: state.uri.queryParameters['topic-id'],
        $extra: state.extra as List<ChatRoomEntity>?,
      );

  String get location => GoRouteData.$location(
        '/chats/${Uri.encodeComponent(_$InterviewTypeEnumMap[type]!)}',
        queryParams: {
          if (topicId != null) 'topic-id': topicId,
        },
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        type: _$InterviewTypeEnumMap._$fromName(state.pathParameters['type']!),
        roomId: state.pathParameters['roomId']!,
      );

  String get location => GoRouteData.$location(
        '/chats/${Uri.encodeComponent(_$InterviewTypeEnumMap[type]!)}/${Uri.encodeComponent(roomId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}
