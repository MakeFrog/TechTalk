import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_qna_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qna_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qnas_provider.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_bookmark_filter_provider.dart';

mixin class LearningDetailState {
  ///
  /// 선택된 주제의 문답 리스트
  ///
  AsyncValue<List<SelectableQnaEntity<CommonQnaEntity>>> qnasAsync(
      WidgetRef ref) {
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
  List<SelectableQnaEntity<CommonQnaEntity>> qnas(WidgetRef ref) =>
      ref.watch(studyQnasProvider(selectedTopic(ref).id)).requireValue;

  ///
  /// 컨트롤러(pageView)
  ///
  PageController controller(WidgetRef ref) =>
      ref.watch(studyQnaControllerProvider);

  ///
  /// 북마크 모아보기 필터 활성화 여부
  ///
  bool isBookmarkFilterActive(WidgetRef ref) =>
      ref.watch(studyBookmarkFilterProvider);

  /// 북마크 필터링된 리스트를 반환
  List<SelectableQnaEntity<CommonQnaEntity>> getFilteredQnas(
    WidgetRef ref,
    bool isBookmarkFilterActive,
  ) {
    return isBookmarkFilterActive
        ? qnas(ref).where((qna) => qna.isSelected).toList()
        : qnas(ref);
  }

  /// 현재 아이템의 필터링된 인덱스를 반환
  int getFilteredCurrentIndex(
    WidgetRef ref,
    int currentIndex,
    bool isBookmarkFilterActive,
    List<SelectableQnaEntity<CommonQnaEntity>> filteredQnas,
  ) {
    return isBookmarkFilterActive
        ? filteredQnas
            .indexWhere((qna) => qna.qna.id == qnas(ref)[currentIndex].qna.id)
        : currentIndex;
  }

  /// 현재 아이템으로 스크롤
  void scrollToCurrentItem(
    List<GlobalKey> itemKeys,
    int filteredCurrentIndex,
  ) {
    if (filteredCurrentIndex >= 0 &&
        itemKeys[filteredCurrentIndex].currentContext != null) {
      Scrollable.ensureVisible(itemKeys[filteredCurrentIndex].currentContext!);
    }
  }
}
