import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(
    WidgetRef ref, {
    required Topic topic,
  });
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(
    WidgetRef ref, {
    required Topic topic,
  }) {
    ref.read(selectedStudyTopicProvider.notifier).update(topic);

    StudyRoute(topic.id).push(rootNavigatorKey.currentContext!);
  }
}
