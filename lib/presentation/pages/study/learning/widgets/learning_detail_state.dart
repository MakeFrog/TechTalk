import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_qna_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qna_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qnas_provider.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';

mixin class LearningDetailState {
  ///
  /// 선택된 주제의 문답 리스트
  ///
  AsyncValue<List<QnaEntity>> qnasAsync(WidgetRef ref) {
    return ref.watch(studyQnasProvider(selectedTopic(ref).id));
  }

  ///
  /// 선택된 주제
  ///
  TopicEntity selectedTopic(WidgetRef ref) =>
      ref.watch(selectedStudyTopicProvider);

  ///
  /// 현재 문답 목록 인덱스
  ///
  int currentIndex(WidgetRef ref) => ref.watch(currentStudyQnaIndexProvider);

  ///
  /// 문답 목록
  ///
  List<QnaEntity> qnas(WidgetRef ref) =>
      ref.watch(studyQnasProvider(selectedTopic(ref).id)).requireValue;

  ///
  /// 컨트롤러(pageView)
  ///
  PageController controller(WidgetRef ref) =>
      ref.watch(studyQnaControllerProvider);
}
