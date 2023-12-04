import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract interface class _HomeEvent {
  void onTapNewTopicInterview(BuildContext context);

  void onTapGoToInterviewRoomPage(
    BuildContext context, {
    required InterviewTopic topic,
  });
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapNewTopicInterview(BuildContext context) {
    const HomeTopicSelectRoute().push(context);
  }

  @override
  void onTapGoToInterviewRoomPage(
    BuildContext context, {
    required InterviewTopic topic,
  }) {
    // TODO : 토픽 전달 후 데이터 변경 필요
    const ChatListPageRoute().push(context);
  }
}
