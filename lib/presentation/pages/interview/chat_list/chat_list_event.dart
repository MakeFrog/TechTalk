import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class ChatListEvent {
  /// 채팅 페이지로 이동
  void routeToChatPage(
    BuildContext context, {
    required ChatRoomEntity room,
  }) {
    ChatPageRoute(room).push(context);
  }

  /// 면접 질문 갯수 선택 페이지로 이동
  void routeToQuestionCountSelectPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    QuestionCountSelectPageRoute(
      InterviewType.singleTopic,
      $extra: [topic],
    ).push(ref.context);
  }

  void routeToTopicSelectPage(WidgetRef ref) {
    InterviewTopicSelectRoute(
      InterviewType.practical,
    ).push(ref.context);
  }
}
