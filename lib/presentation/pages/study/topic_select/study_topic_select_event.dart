import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(TopicEntity topic);
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(TopicEntity topic) {
    StudyRoute(topic.id).push(rootNavigatorKey.currentContext!);
  }
}
