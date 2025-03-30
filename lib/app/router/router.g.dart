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
          path: 'select-common-interview-type',
          name: 'select-common-interview-type',
          factory: $SelectedCommonInterviewTypeRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'topic-select',
          name: 'topic select',
          factory: $InterviewTopicSelectRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'question-count-select',
          name: 'question count select',
          factory: $QuestionCountSelectPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'profile-setting',
          name: 'profile-setting',
          factory: $ProfileSettingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'proficiency-interview-topic-selection',
          name: 'proficiency-interview-topic-selection',
          factory: $ProficiencyInterviewTopicSelectionRouteExtension._fromState,
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
          path: 'created-question-list',
          factory: $CreatedQuestionListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'study/:topicId',
          name: 'study',
          factory: $StudyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'wrong-answer-note',
          name: 'wrong answer note',
          factory: $WrongAnswerNoteRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'contents-main-list',
          name: 'contents-main-list',
          factory: $YoutubeContentsMainListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'interview-level-selection',
          name: 'interview-level-selection',
          factory: $InterviewLevelSelectionRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'proficiency-question-creation',
          name: 'proficiency-question-creation',
          factory: $QuestionCreationRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'youtube-detail/:contentId',
          name: 'youtube detail',
          factory: $YoutubeDetailRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'channel-detail-route/:channelId',
          name: 'channel detail route',
          factory: $ChannelDetailRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'youtube-link-submit',
          name: 'youtube link submit',
          factory: $YoutubeLinkSubmitRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'my-youtube-board',
          name: 'my youtube board',
          factory: $MyYoutubeBoardRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'submitted-youtube-confirm-route',
          name: 'submitted youtube confirm route',
          factory: $SubmittedYoutubeConfirmRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'youtube-content-upload-failed',
          name: 'youtube content upload failed',
          factory: $YoutubeContentUploadFailedRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'analyze-youtube',
          name: 'analyze youtube',
          factory: $AnalyzeYoutubeRouteExtension._fromState,
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

extension $SelectedCommonInterviewTypeRouteExtension
    on SelectedCommonInterviewTypeRoute {
  static SelectedCommonInterviewTypeRoute _fromState(GoRouterState state) =>
      const SelectedCommonInterviewTypeRoute();

  String get location => GoRouteData.$location(
        '/select-common-interview-type',
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
        state.uri.queryParameters['interview-type']!,
      );

  String get location => GoRouteData.$location(
        '/topic-select',
        queryParams: {
          'interview-type': interviewType,
        },
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
        state.extra as SelectQuestionCountRouteArg,
      );

  String get location => GoRouteData.$location(
        '/question-count-select',
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

extension $ProficiencyInterviewTopicSelectionRouteExtension
    on ProficiencyInterviewTopicSelectionRoute {
  static ProficiencyInterviewTopicSelectionRoute _fromState(
          GoRouterState state) =>
      ProficiencyInterviewTopicSelectionRoute(
        state.extra as ProficiencyInterviewTopicSelectionRouteArgument,
      );

  String get location => GoRouteData.$location(
        '/proficiency-interview-topic-selection',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
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

extension $CreatedQuestionListRouteExtension on CreatedQuestionListRoute {
  static CreatedQuestionListRoute _fromState(GoRouterState state) =>
      CreatedQuestionListRoute(
        state.extra as CreatedQuestionListRouteArg,
      );

  String get location => GoRouteData.$location(
        '/created-question-list',
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

extension $WrongAnswerNoteRouteExtension on WrongAnswerNoteRoute {
  static WrongAnswerNoteRoute _fromState(GoRouterState state) =>
      WrongAnswerNoteRoute();

  String get location => GoRouteData.$location(
        '/wrong-answer-note',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $YoutubeContentsMainListRouteExtension
    on YoutubeContentsMainListRoute {
  static YoutubeContentsMainListRoute _fromState(GoRouterState state) =>
      YoutubeContentsMainListRoute();

  String get location => GoRouteData.$location(
        '/contents-main-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InterviewLevelSelectionRouteExtension
    on InterviewLevelSelectionRoute {
  static InterviewLevelSelectionRoute _fromState(GoRouterState state) =>
      InterviewLevelSelectionRoute(
        state.extra as InterviewLevelSelectionRouteArg,
      );

  String get location => GoRouteData.$location(
        '/interview-level-selection',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $QuestionCreationRouteExtension on QuestionCreationRoute {
  static QuestionCreationRoute _fromState(GoRouterState state) =>
      QuestionCreationRoute(
        state.extra as QuestionCreationRouteArg,
      );

  String get location => GoRouteData.$location(
        '/proficiency-question-creation',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $YoutubeDetailRouteExtension on YoutubeDetailRoute {
  static YoutubeDetailRoute _fromState(GoRouterState state) =>
      YoutubeDetailRoute(
        state.extra as YoutubeDetailArg,
      );

  String get location => GoRouteData.$location(
        '/youtube-detail/${Uri.encodeComponent(contentId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $ChannelDetailRouteExtension on ChannelDetailRoute {
  static ChannelDetailRoute _fromState(GoRouterState state) =>
      ChannelDetailRoute(
        state.extra as ChannelDetailRouteArg,
      );

  String get location => GoRouteData.$location(
        '/channel-detail-route/${Uri.encodeComponent(channelId)}',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $YoutubeLinkSubmitRouteExtension on YoutubeLinkSubmitRoute {
  static YoutubeLinkSubmitRoute _fromState(GoRouterState state) =>
      const YoutubeLinkSubmitRoute();

  String get location => GoRouteData.$location(
        '/youtube-link-submit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyYoutubeBoardRouteExtension on MyYoutubeBoardRoute {
  static MyYoutubeBoardRoute _fromState(GoRouterState state) =>
      MyYoutubeBoardRoute();

  String get location => GoRouteData.$location(
        '/my-youtube-board',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SubmittedYoutubeConfirmRouteExtension
    on SubmittedYoutubeConfirmRoute {
  static SubmittedYoutubeConfirmRoute _fromState(GoRouterState state) =>
      SubmittedYoutubeConfirmRoute(
        state.extra as SubmittedYoutubeConfirmArg,
      );

  String get location => GoRouteData.$location(
        '/submitted-youtube-confirm-route',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $YoutubeContentUploadFailedRouteExtension
    on YoutubeContentUploadFailedRoute {
  static YoutubeContentUploadFailedRoute _fromState(GoRouterState state) =>
      YoutubeContentUploadFailedRoute(
        failedType: _$YoutubeUploadFailedTypeEnumMap
            ._$fromName(state.uri.queryParameters['failed-type']!),
        $extra: state.extra as Video?,
      );

  String get location => GoRouteData.$location(
        '/youtube-content-upload-failed',
        queryParams: {
          'failed-type': _$YoutubeUploadFailedTypeEnumMap[failedType],
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

const _$YoutubeUploadFailedTypeEnumMap = {
  YoutubeUploadFailedType.timeout: 'timeout',
  YoutubeUploadFailedType.jsonFormatError: 'json-format-error',
  YoutubeUploadFailedType.invalidVideoContent: 'invalid-video-content',
  YoutubeUploadFailedType.tooManyTokensRequired: 'too-many-tokens-required',
  YoutubeUploadFailedType.unknownError: 'unknown-error',
  YoutubeUploadFailedType.unexpectedGptError: 'unexpected-gpt-error',
  YoutubeUploadFailedType.isNotTechContent: 'is-not-tech-content',
  YoutubeUploadFailedType.noCaption: 'no-caption',
  YoutubeUploadFailedType.youtubeVideoFetchedFailed:
      'youtube-video-fetched-failed',
  YoutubeUploadFailedType.tooShortVideo: 'too-short-video',
  YoutubeUploadFailedType.alreadyUploaded: 'already-uploaded',
};

extension $AnalyzeYoutubeRouteExtension on AnalyzeYoutubeRoute {
  static AnalyzeYoutubeRoute _fromState(GoRouterState state) =>
      AnalyzeYoutubeRoute(
        state.extra as YoutubeVideoEntity,
      );

  String get location => GoRouteData.$location(
        '/analyze-youtube',
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

const _$InterviewTypeEnumMap = {
  InterviewType.commonSingleTopic: 'common-single-topic',
  InterviewType.commonPracticalTopic: 'common-practical-topic',
  InterviewType.proficiency: 'proficiency',
  InterviewType.resume: 'resume',
  InterviewType.youtube: 'youtube',
};

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
