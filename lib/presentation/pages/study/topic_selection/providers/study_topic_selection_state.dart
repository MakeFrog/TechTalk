import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/study_topic_selection_scroll_controller.dart';
import 'package:techtalk/presentation/providers/topic/sorted_topics_provider.dart';

mixin class StudyTopicSelectionState {
  ///
  /// 스크롤 컨트롤러
  ///
  ScrollController scrollController(WidgetRef ref) =>
      ref.watch(studyTopicSelectionScrollControllerProvider);

  ///
  /// 면접 주제 리스트
  ///
  List<TopicEntity> topics(WidgetRef ref) => ref.watch(sortedTopicsProvider);
}
