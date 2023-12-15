import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class _HomeEvent {
  void onTapPracticalInterview();
  void onTapNewTopicInterview();
  void onTapGoToInterviewRoomPage(
    Topic topic,
  );
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapPracticalInterview() {
    // TODO: implement onTapPracticalInterview
  }

  @override
  void onTapNewTopicInterview() {
    const HomeTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  @override
  void onTapGoToInterviewRoomPage(
    Topic topic,
  ) {
    // TODO : 토픽 전달 후 데이터 변경 필요
    const ChatListPageRoute().push(rootNavigatorKey.currentContext!);
  }
}
