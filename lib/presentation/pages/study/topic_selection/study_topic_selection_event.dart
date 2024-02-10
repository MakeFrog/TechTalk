import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class StudyTopicSelectionEvent {
  void onTapCard(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    StudyRoute(topic).push(rootNavigatorKey.currentContext!);
  }
}
