import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_route_arg.dart';

part 'selected_interview_topics_provider.g.dart';

@riverpod
class SelectedInterviewTopics extends _$SelectedInterviewTopics {
  @override
  List<TopicEntity> build() {
    return [];
  }

  static const limitCount = 3;

  void toggleOrRemove(TopicEntity targetTopic) {
    final interviewTopic = ref.watch(interviewTopicSelectRouteArgProvider);

    if (state.contains(targetTopic)) {
      final removedTopics = state..remove(targetTopic);
      state = [...removedTopics];
    } else if (interviewTopic.isPractical && state.length > limitCount) {
      HapticFeedback.vibrate();
      SnackBarService.showSnackBar(
        tr(
          LocaleKeys.interview_maxFourQuestions,
          namedArgs: {
            'number': '${SelectedInterviewTopics.limitCount + 1}',
          },
        ),
      );
    } else if (interviewTopic.isSingleTopic) {
      state = [targetTopic];
    } else {
      state = [...state, targetTopic];
    }
  }
}
