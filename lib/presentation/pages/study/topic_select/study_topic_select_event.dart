import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(InterviewTopic topic);
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(InterviewTopic topic) {
    StudyRoute(topic.name).push(rootNavigatorKey.currentContext!);
  }
}
