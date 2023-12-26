import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class _ChatListEvent {
  /// 채팅 페이지로 이동
  void routeToChatPage(
    BuildContext context, {
    required ChatRoomEntity room,
  });

  /// 면접 질문 갯수 선택 페이지로 이동
  void routeToQuestionCountSelectPage(
    WidgetRef ref, {
    required TopicEntity topic,
  });
}

mixin class ChatListEvent implements _ChatListEvent {
  @override
  void routeToChatPage(
    BuildContext context, {
    required ChatRoomEntity room,
  }) {
    ChatPageRoute(room.topic.id, room.id).go(context);
  }

  @override
  void routeToQuestionCountSelectPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    QuestionCountSelectPageRoute($extra: topic).push(ref.context);
  }
}
