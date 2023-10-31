// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $signInRoute,
      $signUpRoute,
      $homeRoute,
      $chatPageRoute,
      $testPageRoute,
    ];

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

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      name: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
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
