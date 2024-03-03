import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/practical_chat_room_list_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

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
}
