import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class InterviewTopicSelectEvent {
  void onTapTopic(
    InterviewType type,
    ValueNotifier<List<TopicEntity>> notifier,
    TopicEntity topic,
  ) {
    switch (type) {
      case InterviewType.topic:
        notifier.value = [topic];
      case InterviewType.practical:
        if (notifier.value.contains(topic)) {
          notifier.value = notifier.value.toList()..remove(topic);
        } else {
          if (notifier.value.length >= 3) {
            ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
                  content: Text('최대 3개까지 선택 가능합니다.'),
                ),
              );
            return;
          }
          notifier.value = notifier.value.toList()..add(topic);
        }
    }
  }

  /// 면접 문제 개수 페이지로 이동
  void routeToQuestionCountSelect(
    WidgetRef ref, {
    required InterviewType type,
    required List<TopicEntity> topic,
  }) {
    QuestionCountSelectPageRoute(type, $extra: topic)
        .push(rootNavigatorKey.currentContext!);
  }
}
