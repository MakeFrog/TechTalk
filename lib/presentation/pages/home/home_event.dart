import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

abstract interface class _HomeEvent {
  void onTapNewTopicInterview();

  void onTapGoToInterviewRoomPage(
    TopicEntity topic,
  );
}

mixin class HomeEvent implements _HomeEvent {
  @override
  void onTapNewTopicInterview() {
    const HomeTopicSelectRoute().push(rootNavigatorKey.currentContext!);
  }

  @override
  void onTapGoToInterviewRoomPage(
    TopicEntity topic,
  ) {
    // TODO : 토픽 전달 후 데이터 변경 필요
    const ChatListPageRoute().push(rootNavigatorKey.currentContext!);
  }
}
