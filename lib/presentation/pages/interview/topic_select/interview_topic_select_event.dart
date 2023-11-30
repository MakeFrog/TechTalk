import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_topic_provider.dart';

abstract class _InterviewTopicSelectEvent {
  ///
  /// 면접 문제 개수 페이지로 이동
  ///
  void routeToQuestionCountSelect(WidgetRef ref);
}

mixin class InterviewTopicSelectEvent implements _InterviewTopicSelectEvent {
  @override
  void routeToQuestionCountSelect(WidgetRef ref) {
    final selectedTopic = ref.watch(selectedTopicProvider);
    QuestionCountSelectPageRoute(selectedTopic: selectedTopic!)
        .go(rootNavigatorKey.currentContext!);
  }
}
