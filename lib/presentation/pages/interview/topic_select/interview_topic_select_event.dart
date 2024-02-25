import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_interview_topics_provider.dart';

mixin class InterviewTopicSelectEvent {
  ///
  /// 면접 주제가 선택 되었을 때
  ///
  void onTopicItemTapped(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    HapticFeedback.lightImpact();
    ref.read(selectedInterviewTopicsProvider.notifier).toggleOrRemove(topic);
  }

  ///
  /// 면접 문제 개수 페이지로 이동
  ///
  void routeToQuestionCountSelect(
    WidgetRef ref,
  ) {
    final interviewType = ref.read(interviewTopicSelectRouteArgProvider);
    final selectedTopics = ref.read(selectedInterviewTopicsProvider);
    QuestionCountSelectPageRoute(interviewType, $extra: selectedTopics)
        .push(ref.context);
  }
}
