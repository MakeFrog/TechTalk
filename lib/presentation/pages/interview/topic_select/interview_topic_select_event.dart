import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';

abstract class _InterviewTopicSelectEvent {
  ///
  /// 면접 문제 개수 페이지로 이동
  ///
  void routeToQuestionCountSelect(
    WidgetRef ref, {
    required Topic topic,
  });
}

mixin class InterviewTopicSelectEvent implements _InterviewTopicSelectEvent {
  @override
  void routeToQuestionCountSelect(
    WidgetRef ref, {
    required Topic topic,
  }) {
    QuestionCountSelectPageRoute($extra: topic)
        .push(rootNavigatorKey.currentContext!);
  }
}
