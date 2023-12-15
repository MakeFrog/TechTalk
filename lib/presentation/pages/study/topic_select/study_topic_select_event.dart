import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(Topic topic);
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(Topic topic) {
    StudyRoute(topic.id).push(rootNavigatorKey.currentContext!);
  }
}
