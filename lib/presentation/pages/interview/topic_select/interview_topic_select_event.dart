import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_topic_provider.dart';

abstract class _InterviewTopicSelectEvent {
  void onTapTopicCard(
    WidgetRef ref, {
    required Topic topic,
  });

  ///
  /// 면접 문제 개수 페이지로 이동
  ///
  void routeToQuestionCountSelect(WidgetRef ref);
}

mixin class InterviewTopicSelectEvent implements _InterviewTopicSelectEvent {
  @override
  void routeToQuestionCountSelect(WidgetRef ref) {
    const QuestionCountSelectPageRoute().push(rootNavigatorKey.currentContext!);
  }

  @override
  void onTapTopicCard(
    WidgetRef ref, {
    required Topic topic,
  }) {
    ref.read(selectedInterviewTopicProvider.notifier).onTopicSelected(topic);
  }
}
