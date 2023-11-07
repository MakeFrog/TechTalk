import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/enums/interview_topic.enum.dart';

abstract interface class _StudyTopicSelectEvent {
  void onTapCard(
    WidgetRef ref, {
    required InterviewTopic topic,
  });
}

mixin class StudyTopicSelectEvent implements _StudyTopicSelectEvent {
  @override
  void onTapCard(WidgetRef ref, {required InterviewTopic topic}) {
    StudyRoute(topic.name).push(ref.context);
  }
}
