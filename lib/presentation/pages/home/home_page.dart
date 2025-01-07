import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/resume_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/single_topic_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/test_resume_interview_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/base/controller_holder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class HomePage extends BasePage with HomeState, HomeEvent {
  const HomePage({super.key});

  @override
  void onInit(WidgetRef ref) async {
    super.onInit(ref);

    await requestNotificationPermission(ref);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final scrollController = useScrollController();

    return ControllerHolder<ScrollController>(
      controller: scrollController,
      child: userAsync(ref).when(
        data: (_) {
          return ListView(
            controller: scrollController,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            children: const [
              CheerUpMessageCard(),
              Gap(16),
              ResumeInterviewCard(),
              Gap(16),
              PracticalInterviewCard(),
              Gap(16),
              SingleTopicInterviewCard(),
            ],
          );
        },
        error: (e, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ExceptionIndicator(
                title: '오류 발생',
                subTitle: '예상하지 못한 오류가 발생했습니다.\n다시 시도해주세요',
              ),
              FilledButton(
                onPressed: () => onRetryBtnTapped(ref),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34,
                    vertical: 14,
                  ),
                ),
                child: const Text('재시도'),
              )
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  bool get canPop => false;

  @override
  Color? get screenBackgroundColor => AppColor.of.background1;

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => AppBar(
        backgroundColor: AppColor.of.background1,
        title: SvgPicture.asset(
          Assets.iconsTechTalkLogo,
          height: 26,
        ),
      );

  /// TODO: 유튜브 컨텐츠 업데이트를 위함 임시 버튼, 나중에 삭제해야함
  // @override
  // Widget? buildFloatingActionButton(WidgetRef ref) {
  //   final contentsDetails = [
  //     YoutubeContentsDetailEntity(
  //       id: 'fB3MB8TXNXM',
  //       title: 'REST API - 이거 하나로 끝남',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       authorId: 'coding',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'ShmXbPpmIMU',
  //       title: '쉬운 플러터 4강 : AppBar (아빠)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'H_zCqRqg1F0',
  //       title: '쉬운 플러터 5강 : Flexible과 숙제 안해오면 때림',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'Y1Q4-GxIUHc',
  //       title: '쉬운 플러터 6강 : 중요한 커스텀 위젯 문법',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),

  //     ///
  //     YoutubeContentsDetailEntity(
  //       id: 'Q9GA9DUgPEQ',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 2강 (Column, Row 테이블 구성)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: '0KzEXhk7q9k',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 3강 (Stack 사용하여 여러 위젯 중첩하기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'O63NurH5p0Q',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 4강 (GestureDetector 사용하여 터치 감지하기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'PDOaxbdwAbQ',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 5강 (ListView 사용하여 피드 만들기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'SeZPQ93HpeU',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 6강 (ListView 효율적으로 사용하기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'Y673Ofh-b2Y',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 7강 (GridView 사용하기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'NOTuBHVo12g',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 8강 (GridView 효율적으로 사용하기)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'ajVN7-RGSgU',
  //       title: '플러터(Flutter) 앱 개발 - 핵심 강좌 9강 (스크롤 기능 구현)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //     YoutubeContentsDetailEntity(
  //       id: 'JS-Si5GO3iA',
  //       title: '요즘 앱개발은 플러터로 해도 충분한듯 (플러터 설명과 장단점)',
  //       authorId: 'coding',
  //       createdAt: DateTime.now(),
  //       uploadAt: DateTime.now(),
  //       uploadUserId: '8LPeqgBisMaowWLk0Sw4ClNHrk32',
  //       relatedSkillIds: {'android'},
  //       relatedJobs: {JobGroup.ANDROID_DEVELOPER},
  //       contentsLanguage: {ContentsLanguage.korean},
  //       summary: SummaryEntity(
  //         mainTheme: [
  //           'API란 어떤 소프트웨어나 서비스가 제공하는 기능들을 개발자들이 사용할 수 있도록 열어둔 인터페이스를 말합니다. 프론트엔드와 백엔드 소프트웨어들이 서로 상호 작용하고 소통할 수 있게 해주는 수단으로, 유튜브나 날씨 앱과 같이 다양한 서비스에서 사용됩니다. API 사용법은 API 명세에 따라 요청을 보내고 응답을 받아오는 방식으로 이루어지며, 프로그래밍 언어에 구애받지 않고 다양한 소프트웨어 간 상호 작용이 가능합니다. 공개 API는 기업이나 공공 기관이 자신들의 데이터와 서비스입니다'
  //         ],
  //         summaryNotes: [
  //           ParagraphEntity(
  //             title: '💻 API의 역할과 기능',
  //             contents: 'API의 역할과 기능에 대한 설명입니다ㅓㅁ너래ㅑㄴ어래ㅑㄴㅇ러ㅔ먀ㅐ러ㅔ',
  //             timestamp: Duration(seconds: 1),
  //           ),
  //           ParagraphEntity(
  //             title: '🖥️ 윈도우 API와 GUI의 기본 개념',
  //             contents:
  //                 '윈도우 운영 체제에서는 C나 불로 사용하여 윈도우 기능들을 호출할 수 있는 윈도우 API가 있습니다. GUI는 소프트웨어나 서비스에서 버튼과 탭을 클릭하여 사용할 수 있도록 하는 기본 기능입니다. API는 GUI 이해를 돕는 설명서와 함께 개발자들에게 고급 기능을 제공하는 것으로, 이는 개발자가 아닌 사람들에게 이야기하기 어려운 개념입니다.',
  //             timestamp: Duration(minutes: 9, seconds: 46),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ];

  //   return FloatingActionButton(onPressed: () {
  //     for (var contentsDetail in contentsDetails) {
  //       addYoutubeContentsDetail(contentsDetail.id, contentsDetail.toModel());
  //       addYoutubeContentsOverview(
  //         contentsDetail.id,
  //         YoutubeContentsOverviewEntity(
  //           id: contentsDetail.id,
  //           thumbnailImgUrl: 'https://i.ytimg.com/vi/fB3MB8TXNXM/maxresdefault.jpg',
  //           contentsTitle: contentsDetail.title,
  //           author: ContentsAuthorEntity(id: 'yalco-coding', name: '얄팍한 코딩사전'),
  //           relatedJobs: contentsDetail.relatedJobs,
  //           relatedSkillIds: contentsDetail.relatedSkillIds,
  //           videoDuration: Duration(minutes: 13, seconds: 1),
  //           uploadAt: contentsDetail.uploadAt,
  //           createdAt: contentsDetail.createdAt,
  //         ).toModel(),
  //       );

  //       addYoutubeContentsQnas(
  //           contentsDetail.id,
  //           [
  //             QnaEntity(
  //               question: '${contentsDetail.id} : API란 무엇이며, 소프트웨어 간의 통신에서 어떤 역할을 하나요?',
  //               id: 'qna1',
  //               answers: [],
  //               questionInstruction: 'API가 소프트웨어들 간의 상호작용을 어떻게 돕는지 설명해보세요.',
  //             ),
  //             QnaEntity(
  //               question: '${contentsDetail.id} : REST API에서 클라이언트와 서버의 역할은 무엇이며, 이 둘 간의 요청과 응답은 어떻게 이루어지나요?',
  //               id: 'qna2',
  //               answers: [],
  //               questionInstruction: '클라이언트가 서버에 요청을 보내는 방식과 서버가 응답하는 방식에 대해 설명해보세요.',
  //             ),
  //           ].map((e) => e.toModel()).toList());
  //     }
  //   });
  // }
}
