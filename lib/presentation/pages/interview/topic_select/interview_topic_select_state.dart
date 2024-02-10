import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/interview_topic_select_scroll_controller_provider.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/providers/selected_interview_topics_provider.dart';
import 'package:techtalk/presentation/providers/topic/sorted_topics_provider.dart';

mixin class InterviewTopicSelectState {
  ///
  /// 선택된 토픽 리스트
  ///
  List<TopicEntity> selectedTopics(WidgetRef ref) =>
      ref.watch(selectedInterviewTopicsProvider);

  ///
  /// 인터뷰 타입
  ///
  InterviewType interviewType(WidgetRef ref) =>
      ref.watch(interviewTopicSelectRouteArgProvider);

  ///
  /// 면접 주제 리스트
  ///
  List<TopicEntity> topics(WidgetRef ref) => ref.watch(sortedTopicsProvider);

  ///
  /// 버튼 활성화 여부
  ///
  bool isStepBtnActivate(WidgetRef ref) {
    final interviewType = ref.read(interviewTopicSelectRouteArgProvider);
    final selectedTopics = ref.watch(selectedInterviewTopicsProvider);

    if (interviewType.isSingleTopic) {
      return selectedTopics.isNotEmpty;
    } else {
      return selectedTopics.length > 1;
    }
  }

  ///
  /// 스크롤 컨트롤러
  ///
  ScrollController scrollController(WidgetRef ref) =>
      ref.watch(interviewTopicSelectScrollControllerProvider);
}
