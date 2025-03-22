import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_page.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_page.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/constant/interview_level_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/interview_level_selection_page.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/constant/proficiency_interview_topic_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/proficiency_interview_topic_selection_page.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_question_creation/constant/proficiency_question_creation_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_question_creation/proficiency_question_creation_page.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/constant/select_question_count_route_argument.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_page.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_page.dart';
import 'package:techtalk/presentation/pages/main/main_page.dart';
import 'package:techtalk/presentation/pages/my_info/job_group_setting/job_group_setting_page.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/my_youtube_board_page.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/profile_setting_page.dart';
import 'package:techtalk/presentation/pages/my_info/skill_setting/skill_setting_page.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_page.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page.dart';
import 'package:techtalk/presentation/pages/splash/splash_page.dart';
import 'package:techtalk/presentation/pages/study/learning/learning_detail_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_detail_page.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_page.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/channel_detail_page.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_detail_page.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_page.dart';
import 'package:techtalk/presentation/pages/youtube/upload/analyze_youtube/analyze_youtube_page.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/submitted_youtube_confirm_page.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/youtube_link_submit_page.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/provider/youtube_upload_failed_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/youtube_upload_fail_page.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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

abstract final class AppRouter {
  static GoRouter appRouter(WidgetRef ref) => GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: rootNavigatorKey,
        initialLocation: SplashRoute.path,
        routes: $appRoutes,
      );
}

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
      child: const SignInPage(),
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
    ),
    TypedGoRoute<QuestionCountSelectPageRoute>(
      path: QuestionCountSelectPageRoute.path,
      name: QuestionCountSelectPageRoute.name,
    ),
    TypedGoRoute<ProfileSettingRoute>(
      path: ProfileSettingRoute.name,
      name: ProfileSettingRoute.name,
    ),
    TypedGoRoute<ProficiencyInterviewTopicSelectionRoute>(
      path: ProficiencyInterviewTopicSelectionRoute.path,
      name: ProficiencyInterviewTopicSelectionRoute.path,
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
    TypedGoRoute<WrongAnswerNoteRoute>(
      path: WrongAnswerNoteRoute.path,
      name: WrongAnswerNoteRoute.name,
    ),
    TypedGoRoute<YoutubeContentsMainListRoute>(
      path: YoutubeContentsMainListRoute.path,
      name: YoutubeContentsMainListRoute.name,
    ),
    TypedGoRoute<InterviewLevelSelectionRoute>(
      path: InterviewLevelSelectionRoute.path,
      name: InterviewLevelSelectionRoute.path,
    ),
    TypedGoRoute<ProficiencyQuestionCreationRoute>(
      path: ProficiencyQuestionCreationRoute.path,
      name: ProficiencyQuestionCreationRoute.path,
    ),
    TypedGoRoute<YoutubeDetailRoute>(
      path: YoutubeDetailRoute.path,
      name: YoutubeDetailRoute.name,
    ),
    TypedGoRoute<ChannelDetailRoute>(
      path: ChannelDetailRoute.path,
      name: ChannelDetailRoute.name,
    ),
    TypedGoRoute<YoutubeLinkSubmitRoute>(
      path: YoutubeLinkSubmitRoute.path,
      name: YoutubeLinkSubmitRoute.name,
    ),
    TypedGoRoute<MyYoutubeBoardRoute>(
      path: MyYoutubeBoardRoute.path,
      name: MyYoutubeBoardRoute.name,
    ),
    TypedGoRoute<SubmittedYoutubeConfirmRoute>(
      path: SubmittedYoutubeConfirmRoute.path,
      name: SubmittedYoutubeConfirmRoute.name,
    ),
    TypedGoRoute<YoutubeContentUploadFailedRoute>(
      path: YoutubeContentUploadFailedRoute.path,
      name: YoutubeContentUploadFailedRoute.name,
    ),
    TypedGoRoute<AnalyzeYoutubeRoute>(
      path: AnalyzeYoutubeRoute.path,
      name: AnalyzeYoutubeRoute.name,
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
      child: const MainPage(),
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
    return const LearningDetailPage();
  }
}

class ProficiencyInterviewTopicSelectionRoute extends GoRouteData {
  ProficiencyInterviewTopicSelectionRoute(this.$extra);

  static const String path = 'proficiency-interview-topic-selection';

  final ProficiencyInterviewTopicSelectionRouteArgument $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProficiencyInterviewTopicSelectionPage($extra);
  }
}

class WrongAnswerNoteRoute extends GoRouteData {
  static const String path = 'wrong-answer-note';
  static const String name = 'wrong answer note';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WrongAnswerNotePage();
  }
}

class MyYoutubeBoardRoute extends GoRouteData {
  static const String path = 'my-youtube-board';
  static const String name = 'my youtube board';
  static late TopicEntity arg;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyYoutubeBoardPage();
  }
}

class ChannelDetailRoute extends GoRouteData {
  static const String path = 'channel-detail-route/:channelId';
  static const String name = 'channel detail route';

  ChannelDetailRoute(this.$extra) : channelId = $extra.channel.id;

  final ChannelDetailRouteArg $extra;

  final String channelId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChannelDetailPage($extra);
  }
}

class YoutubeContentsMainListRoute extends GoRouteData {
  YoutubeContentsMainListRoute();

  static const String path = 'contents-main-list';
  static const String name = 'contents-main-list';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YoutubeMainPage();
  }
}

class InterviewLevelSelectionRoute extends GoRouteData {
  const InterviewLevelSelectionRoute(this.$extra);

  static const String path = 'interview-level-selection';

  final InterviewLevelSelectionRouteArg $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InterviewLevelSelectionPage($extra);
  }
}

class ProficiencyQuestionCreationRoute extends GoRouteData {
  const ProficiencyQuestionCreationRoute(this.$extra);

  static const String path = 'proficiency-question-creation';

  final ProficiencyQuestionCreationRouteArg $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProficiencyQuestionCreationPage($extra);
  }
}

class YoutubeDetailRoute extends GoRouteData {
  YoutubeDetailRoute(this.$extra) : contentId = $extra.contentId;

  static const String path = 'youtube-detail/:contentId';
  static const String name = 'youtube detail';

  final YoutubeDetailArg $extra;

  final String contentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return YoutubeDetailPage(
      argument: $extra,
    );
  }
}

class YoutubeLinkSubmitRoute extends GoRouteData {
  const YoutubeLinkSubmitRoute();

  static const String path = 'youtube-link-submit';
  static const String name = 'youtube link submit';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const YoutubeLinkSubmitPage();
  }
}

class SubmittedYoutubeConfirmRoute extends GoRouteData {
  const SubmittedYoutubeConfirmRoute(
    this.$extra,
  );

  final SubmittedYoutubeConfirmArg $extra;

  static const String path = 'submitted-youtube-confirm-route';
  static const String name = 'submitted youtube confirm route';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SubmittedYoutubeConfirmPage(
      arg: $extra,
    );
  }
}

class AnalyzeYoutubeRoute extends GoRouteData {
  const AnalyzeYoutubeRoute(
    this.$extra,
  );

  final YoutubeVideoEntity $extra;

  static const String path = 'analyze-youtube';
  static const String name = 'analyze youtube';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnalyzeYoutubePage(
      video: $extra,
    );
  }
}

class YoutubeContentUploadFailedRoute extends GoRouteData {
  const YoutubeContentUploadFailedRoute({
    required this.failedType,
    this.$extra,
  });

  static const String path = 'youtube-content-upload-failed';
  static const String name = 'youtube content upload failed';

  final YoutubeUploadFailedType failedType;

  final Video? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return YoutubeUploadFailedPage(
      arg: YoutubeUploadFailedArg(
        type: failedType,
        video: $extra,
      ),
    );
  }
}

class WrongAnswerRoute extends GoRouteData {
  const WrongAnswerRoute(this.index);

  final int index;
  static const String path = 'wrong-answer/:index';
  static const String name = 'wrong answer';
  static late int arg;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    arg = index;
    return const WrongAnswerDetailPage();
  }
}

class InterviewTopicSelectRoute extends GoRouteData {
  InterviewTopicSelectRoute(this.interviewType);

  static const String path = 'topic-select';
  static const String name = 'topic select';
  static late InterviewType arg;

  final String interviewType;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    arg = InterviewType.getByName(interviewType);
    return const InterviewTopicSelectPage();
  }
}

class QuestionCountSelectPageRoute extends GoRouteData {
  const QuestionCountSelectPageRoute(this.$extra);

  final SelectQuestionCountRouteArg $extra;

  static const String path = 'question-count-select';
  static const String name = 'question count select';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QuestionCountSelectPage(argument: $extra);
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

  /// NOTE: $extra 이슈로 직접 업데이트
  void updateArg({required ChatRoomEntity room}) {
    arg = room;
  }
}
