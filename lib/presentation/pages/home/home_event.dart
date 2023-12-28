import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class HomeEvent {
  void onTapPracticalInterview() {
    // TODO: implement onTapPracticalInterview
  }

  void onTapNewTopicInterview() {
    const InterviewTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  void onTapGoToInterviewRoomListPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    ChatListPageRoute(topic.id).push(rootNavigatorKey.currentContext!);
  }
}
