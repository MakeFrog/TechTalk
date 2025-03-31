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
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/interview/use_case/start_interview_flow_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

part 'internal_home_event.p.dart';

mixin class HomeEvent {
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
    InterviewTopicSelectRoute(type.name).push(context);
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
  /// 유튜브 카드뷰가 클릭 되었을 때
  ///
  void onYoutubeFeatureCardTapped(WidgetRef ref) {
    ref
        .read(mainBottomNavigationProvider.notifier)
        .changeTab(MainNavigationTab.youtube);
  }

  ///
  /// AI 면접 카드가 탭 되었을 때
  ///
  void onAiInterviewCardTapped(WidgetRef ref) {
    // ProficiencyInterviewTopicSelectionRoute().push(ref.context);
    // InterviewLevelSelectionRoute().push(ref.context);
    //
    // return;

    final param = ProficiencyInterviewFlowParam.initial();

    StartInterviewFlowUseCase(param).executeProficiencyInterviewFlow();
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
}
