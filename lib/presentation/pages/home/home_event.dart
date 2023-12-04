import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract interface class _HomeEvent {
  void onTapNewTopicInterview();

  void onTapGoToInterviewRoomPage(
    InterviewTopic topic,
  );
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapNewTopicInterview() {
    const HomeTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  @override
  void onTapGoToInterviewRoomPage(
    InterviewTopic topic,
  ) {
    // TODO : 토픽 전달 후 데이터 변경 필요
    const ChatListPageRoute().push(rootNavigatorKey.currentContext!);
  }
}
