import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class _HomeEvent {
  void onTapPracticalInterview();
  void onTapNewTopicInterview();
  void onTapGoToInterviewRoomListPage(
    WidgetRef ref, {
    required TopicEntity topic,
  });
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapPracticalInterview() {
    // TODO: implement onTapPracticalInterview
  }

  @override
  void onTapNewTopicInterview() {
    const InterviewTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  @override
  void onTapGoToInterviewRoomListPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    ChatListPageRoute(topic).push(rootNavigatorKey.currentContext!);
  }
}
