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
      name: '/splash',
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
      name: '/sign_in',
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
      name: '/sign-up',
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
          factory: $HomeTopicSelectRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'question-count-select',
              name: 'question-count-select',
              factory: $QuestionCountSelectPageRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'study',
          name: 'study',
          factory: $StudyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'profile-setting',
          name: 'profile-setting',
          factory: $ProfileSettingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'chat-list',
          name: 'chat-list',
          factory: $ChatListPageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'chat',
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

extension $HomeTopicSelectRouteExtension on HomeTopicSelectRoute {
  static HomeTopicSelectRoute _fromState(GoRouterState state) =>
      const HomeTopicSelectRoute();

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
        selectedTopic: _$InterviewTopicEnumMap
            ._$fromName(state.uri.queryParameters['selected-topic']!),
      );

  String get location => GoRouteData.$location(
        '/topic-select/question-count-select',
        queryParams: {
          'selected-topic': _$InterviewTopicEnumMap[selectedTopic],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$InterviewTopicEnumMap = {
  InterviewTopic.java: 'java',
  InterviewTopic.spring: 'spring',
  InterviewTopic.react: 'react',
  InterviewTopic.swift: 'swift',
  InterviewTopic.flutter: 'flutter',
  InterviewTopic.android: 'android',
  InterviewTopic.dataStructure: 'data-structure',
  InterviewTopic.operatingSystem: 'operating-system',
};

extension $StudyRouteExtension on StudyRoute {
  static StudyRoute _fromState(GoRouterState state) => StudyRoute(
        state.uri.queryParameters['topic-id']!,
      );

  String get location => GoRouteData.$location(
        '/study',
        queryParams: {
          'topic-id': topicId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

extension $ChatListPageRouteExtension on ChatListPageRoute {
  static ChatListPageRoute _fromState(GoRouterState state) =>
      const ChatListPageRoute();

  String get location => GoRouteData.$location(
        '/chat-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        progressState: _$InterviewProgressStateEnumMap
            ._$fromName(state.uri.queryParameters['progress-state']!),
        roomId: state.uri.queryParameters['room-id']!,
        topic: _$InterviewTopicEnumMap
            ._$fromName(state.uri.queryParameters['topic']!),
        interviewer: _$InterviewerAvatarEnumMap
            ._$fromName(state.uri.queryParameters['interviewer']!),
        $extra: state.extra as ChatQnaProgressInfoEntity,
      );

  String get location => GoRouteData.$location(
        '/chat-list/chat',
        queryParams: {
          'progress-state': _$InterviewProgressStateEnumMap[progressState],
          'room-id': roomId,
          'topic': _$InterviewTopicEnumMap[topic],
          'interviewer': _$InterviewerAvatarEnumMap[interviewer],
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

const _$InterviewProgressStateEnumMap = {
  InterviewProgressState.initial: 'initial',
  InterviewProgressState.ongoing: 'ongoing',
  InterviewProgressState.completed: 'completed',
};

const _$InterviewerAvatarEnumMap = {
  InterviewerAvatar.bluePlus: 'blue-plus',
  InterviewerAvatar.greenPlus: 'green-plus',
  InterviewerAvatar.purplePlus: 'purple-plus',
  InterviewerAvatar.redPlus: 'red-plus',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}
