import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class InterviewTopicSelectEvent {
  /// 면접 문제 개수 페이지로 이동
  void routeToQuestionCountSelect(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    QuestionCountSelectPageRoute($extra: topic)
        .push(rootNavigatorKey.currentContext!);
  }
}
