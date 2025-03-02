import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/use_cases/create_gemini_resume_question_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';
import 'package:techtalk/presentation/pages/resume/providers/resume_info_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

part 'internal_home_event.p.dart';

mixin class HomeEvent {
  ///
  /// [CreateResumeQuestionUseCase]를 호출하여 결과를 출력하는 테스트 메서드
  /// 테스트를 위한 임시 코드
  ///
//   Future<void> testSetAiResumeQuestionUseCase() async {
//     // 시작 시간 기록
//     final DateTime startTime = DateTime.now();

//     // 이력서 TXT 예시 (PDF to TXT)
//     const String resumeContent = '''

// 이름 : 김윤수

// 주요 강점
// 요구사항 이해 및 빠른 개발

// Flutter 앱 3개 상용화 및 유지 보수 경험.
// 요구사항을 빠르게 이해하고 기한 내에 구현.
// 능동적인 아키텍처 설계

// 선언형 UI 패러다임에 맞는 아키텍처 설계 경험.
// 코드 품질 및 구조적 개선으로 코드 리뷰 시간 20% 단축.
// 문서화 생활화

// 기술 기획 문서를 작성하여 개발 과정 문제를 사전 점검.
// 체계적인 문서화를 통해 업무 효율 향상.

// 프로젝트 및 핵심 성과
// 테크톡 - AI 면접관과 함께 준비하는 개발 면접

// 팀 프로젝트: 7명 (기획자, 디자이너, Flutter 개발자)
// 기간: 2024.07.06 ~ 진행 중
// 성과:
// 글로벌 서비스 론칭을 위한 easy_localization 패키지 활용.
// 기존 코드 수정 최소화를 위한 Firestore DB 구조 변경 솔루션 제공.
// Whisper API를 활용한 음성 면접 기능 구현으로 응답률 34% → 56% 개선.
// 핏플 - 자영업자를 위한 근태관리 서비스

// 팀 프로젝트: 4명
// 기간: 2024.05.18 ~ 2024.09.19
// 성과:
// Flutter 학습 자료 제작 및 협업 효율성 향상.
// 클린 아키텍처 설계로 코드 리뷰 시간 20% 단축.
// 밤하늘 - 목소리로 소통하는 음성 SNS

// 개인 프로젝트: 1명
// 기간: 2024.03.27 ~ 2024.06.02
// 성과:
// 앱 기획부터 디자인 및 개발까지 독자 수행.
// 음성 게시물 및 답장 기능 구현.
// 악성 유저 관리 기능 개발.

// 기술 스택
// Dart & Flutter

// Provider, Riverpod, MVVM, Clean Architecture 등.
// Hive, Go_router, Dio, Get_it, Freezed, JSON-SERIALIZED.
// Firebase

// Firestore, Authentication, Storage.
// 툴
// Postman, GitHub, Figma, Jira, Slack.


// ''';

//     // 포트폴리오 TXT 예시 (PDF to TXT)
//     const String portfolioContent = '''
// 이름 : 김윤수 
// 프로젝트
// 테크톡 - AI 면접관과 함께 준비하는 개발 면접
// 팀 프로젝트: 7명 (기획자, 디자이너, Flutter 개발자)
// 기간: 2024.07.06 ~ 진행 중
// 설명:
// AI 면접, 오답 및 기술 노트를 통해 기술 면접을 대비하는 서비스로, Whisper API를 사용하여 음성 면접 기능을 구현하고 응답률을 34%에서 56%로 개선.
// 기여 내용:
// easy_localization으로 글로벌 서비스 지원.
// Firestore DB 구조 변경으로 기존 코드 수정 최소화.
// 새로운 UI를 디자이너에게 제안하여 UX 개선.
// Whisper API로 음성 인식 및 처리 개선.
// 핏플 - 자영업자를 위한 근태관리 서비스
// 팀 프로젝트: 4명
// 기간: 2024.05.18 ~ 2024.09.19
// 설명:
// 소상공인을 위한 근태관리 앱. 근무 일정, 출퇴근 기록 관리.
// 기술 스택:
// Dart, Flutter, Riverpod, Firebase, Clean Architecture, Freezed.
// 기여 내용:
// 클린 아키텍처 설계로 유지보수성 향상.
// 통일된 용어 사전 제작으로 협업 효율성 증대.
// 로그인 및 CRUD 구현.
// 코드 리뷰 시간 20% 단축.
// 밤하늘 - 목소리로 소통하는 음성 SNS
// 개인 프로젝트
// 기간: 2024.03.27 ~ 2024.06.02
// 설명:
// 음성 게시물 작성, 1:1 음성 채팅 등을 통해 소통하는 SNS.
// 기술 스택:
// Dart, Flutter, Provider, Firebase, MVVM, AudioPlayer.
// 기여 내용:
// Figma로 디자인 시스템 구축.
// 음성 게시물 및 답장 기능 구현.
// 악성 유저 관리 시스템 개발.
// 기술 스택
// Dart & Flutter
// Provider, Riverpod, Clean Architecture, MVVM 등.
// Firebase
// Firestore, Authentication, Storage.
// 툴
// Postman, GitHub, Figma, Jira, Slack.
// ''';

//     final useCase = CreateResumeQuestionUseCase();

//     // 입력 파라미터 생성
//     const param =
//         (resumeContent: resumeContent, portfolioContent: portfolioContent);

//     debugPrint('===== GPT에 응답을 요청했습니다 잠시만 기다려주세요 =====');

//     try {
//       final result = await useCase.call(param);
//       result.fold(
//         onSuccess: (qnaEntities) {
//           debugPrint("AI 분석 성공");
//         },
//         onFailure: (error) {
//           debugPrint("AI 분석 실패: $error");
//         },
//       );
//     } catch (e) {
//       log("UseCase 실행 중 예외 발생: $e");
//     }

//     // 종료 시간 기록
//     final DateTime endTime = DateTime.now();

//     // 시간 차이를 계산
//     final duration = endTime.difference(startTime).inMilliseconds;

//     // 실행 시간 출력
//     debugPrint('===== 프롬프트 출력 시간: ${duration}ms =====');
//   }

  ///
  /// 실전 면접 카드(전체 영역)가 클릭 되었을 때
  /// 실전 면접 기록 여부에 따라 라우팅을 다르게 진행
  ///
  Future<void> onPracticalCardTapped(WidgetRef ref) async {
    await EasyLoading.show();

    final hasNotPracticalInterviewRecord =
        !ref.read(userInfoProvider).requireValue!.hasPracticalInterviewRecord;

    if (hasNotPracticalInterviewRecord) {
      final chatRooms = await ref.read(practicalChatRoomListProvider.future);
      if (chatRooms.isEmpty) {
        routeToTopicSelectPage(ref.context,
            type: InterviewType.commonPracticalTopic);
      } else {
        routeToChatListPage(ref.context,
            type: InterviewType.commonPracticalTopic, rooms: chatRooms);
        unawaited(ref
            .read(userInfoProvider.notifier)
            .storeUserPracticalRecordExistInfo());
      }
    } else {
      routeToChatListPage(ref.context,
          type: InterviewType.commonPracticalTopic);
    }

    unawaited(EasyLoading.dismiss());
  }

  ///
  /// 면접 주제 선택(주제별, 실전) 페이지로 이동
  ///
  void routeToTopicSelectPage(BuildContext context,
      {required InterviewType type}) {
    InterviewTopicSelectRoute(type).push(context);
  }

  ///
  /// 채팅 리스트(먼접실) 페이지로 이동
  ///
  void routeToChatListPage(BuildContext context,
      {required InterviewType type,
      List<ChatRoomEntity>? rooms,
      String? topicId}) {
    ChatListRoute(type, topicId: topicId, $extra: rooms).push(context);
  }

  ///
  /// 재시도 버튼이 클릭 되었을 때
  ///
  void onRetryBtnTapped(WidgetRef ref) {
    StoredTopics.initialize();
    ref.invalidate(userAuthProvider);
    ref.invalidate(userInfoProvider);
    ref.invalidate(mainBottomNavigationProvider);
    ref.invalidate(userTopicsProvider);
    SplashRoute().go(ref.context);
  }

  ///
  ///
  ///
  void routeToResumeChatList(WidgetRef ref) {
    /// TODO : XIMYA
    /// 임시 코드

    final room = ChatRoomEntity.generateResumeInterview(
      qnas: tempResumeQnaList,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.go(ref.context);
    return;
  }

  ///
  /// 이력서 채팅 면접 페이지로 이동
  ///
  void routeToResumeInterviewChat(WidgetRef ref) {}

  ///
  /// 이력서 등록 안내 페이지로 이동
  ///
  void routeToResumeRegistGuidePage(WidgetRef ref) {
    const ResumeRegistGuideRoute().push(ref.context);
  }

  ///
  /// 이력서 등록 페이지로 이동
  ///
  void routeToResumeUploadPage(WidgetRef ref) {
    const ResumeInterviewRoute(InterviewType.resume).push(ref.context);
  }
}
