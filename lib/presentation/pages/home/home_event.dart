import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/set_ai_resume_question_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

part 'internal_home_event.p.dart';

mixin class HomeEvent {
  ///
  /// [SetAiResumeQuestionUseCase]를 호출하여 결과를 출력하는 테스트 메서드
  /// 테스트를 위한 임시 코드
  ///
  Future<void> testSetAiResumeQuestionUseCase({
    required bool isFile,
    required String resumeOrPortfolioContent,
  }) async {
    final useCase = SetAiResumeQuestionUseCase();

    // 입력 파라미터 생성
    final param = (
      isFile: isFile,
      resumeOrPortfolioContent: resumeOrPortfolioContent,
    );

    print('===== GPT에 응답을 요청했습니다 잠시만 기다려주세요 =====');

    try {
      final result = await useCase.call(param);
      result.fold(
        onSuccess: (qnaEntities) {
          print("AI 분석 성공: $qnaEntities");
        },
        onFailure: (error) {
          print("AI 분석 실패: $error");
        },
      );
    } catch (e) {
      log("UseCase 실행 중 예외 발생: $e");
    }
  }

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
        routeToTopicSelectPage(ref.context, type: InterviewType.practical);
      } else {
        routeToChatListPage(ref.context,
            type: InterviewType.practical, rooms: chatRooms);
        unawaited(ref
            .read(userInfoProvider.notifier)
            .storeUserPracticalRecordExistInfo());
      }
    } else {
      routeToChatListPage(ref.context, type: InterviewType.practical);
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
}
