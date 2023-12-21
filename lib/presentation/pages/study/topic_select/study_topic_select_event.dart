import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(
    WidgetRef ref, {
    required TopicEntity topic,
  });
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    StudyRoute(topic.id).push(rootNavigatorKey.currentContext!);
  }
}
