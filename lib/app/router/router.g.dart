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
      $chatPageRoute,
      $testPageRoute,
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
        ),
        GoRouteData.$route(
          path: 'study',
          name: 'study',
          factory: $StudyRouteExtension._fromState,
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

extension $StudyRouteExtension on StudyRoute {
  static StudyRoute _fromState(GoRouterState state) => StudyRoute(
        state.uri.queryParameters['topic-name']!,
      );

  String get location => GoRouteData.$location(
        '/study',
        queryParams: {
          'topic-name': topicName,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chatPageRoute => GoRouteData.$route(
      path: '/chat',
      name: '/chat',
      factory: $ChatPageRouteExtension._fromState,
    );

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        progressState: _$InterviewProgressStateEnumMap
            ._$fromName(state.uri.queryParameters['progress-state']!),
        roomId: state.uri.queryParameters['room-id'],
        topic: _$InterviewTopicEnumMap
            ._$fromName(state.uri.queryParameters['topic']!),
      );

  String get location => GoRouteData.$location(
        '/chat',
        queryParams: {
          'progress-state': _$InterviewProgressStateEnumMap[progressState],
          if (roomId != null) 'room-id': roomId,
          'topic': _$InterviewTopicEnumMap[topic],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$InterviewProgressStateEnumMap = {
  InterviewProgressState.initial: 'initial',
  InterviewProgressState.ongoing: 'ongoing',
  InterviewProgressState.completed: 'completed',
};

const _$InterviewTopicEnumMap = {
  InterviewTopic.swift: 'swift',
  InterviewTopic.flutter: 'flutter',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $testPageRoute => GoRouteData.$route(
      path: '/test',
      name: '/test',
      factory: $TestPageRouteExtension._fromState,
    );

extension $TestPageRouteExtension on TestPageRoute {
  static TestPageRoute _fromState(GoRouterState state) => const TestPageRoute();

  String get location => GoRouteData.$location(
        '/test',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
