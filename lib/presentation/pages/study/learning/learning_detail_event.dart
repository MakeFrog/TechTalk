import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/current_study_qna_index_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qna_controller.dart';
import 'package:techtalk/presentation/providers/topic/selectable_qnas_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/entire_question_list_view.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_bookmark_filter_provider.dart';

mixin class LearningDetailEvent {
  void onToggleAnswerBlur(WidgetRef ref) {
    ref.read(studyAnswerBlurProvider.notifier).toggle();
  }

  void onQuestionPageChanged(WidgetRef ref) {
    ref.invalidate(currentStudyQnaIndexProvider);
  }

  void onTapPrevQuestion(WidgetRef ref) {
    ref.read(studyQnaControllerProvider.notifier).prev();
  }

  Future<void> onTapEntireQuestion(WidgetRef ref) async {
    /// 현재 화면에 보이고 있는 qna의 북마크 여부 확인
    final currentQnaIndex = ref.read(currentStudyQnaIndexProvider);
    final currentQna = ref
        .read(selectableQnasProvider(ref.read(selectedStudyTopicProvider).id))
        .value?[currentQnaIndex];
    final isCurrentQnaBookmarked = currentQna?.isSelected ?? false;

    if (!isCurrentQnaBookmarked &&
        LearningDetailState().isShowBookMarkOnlyFilterActive(ref)) {
      ref.read(studyBookmarkFilterProvider.notifier).toggle();
    }
    final selectedQuestionIndex = await Navigator.push<int>(
      ref.context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EntireQuestionListView(
          topic: ref.read(selectedStudyTopicProvider),
        ),
      ),
    );

    if (selectedQuestionIndex != null) {
      ref.read(studyQnaControllerProvider).jumpToPage(selectedQuestionIndex);
    }
  }

  void onTapNextQuestion(WidgetRef ref) {
    ref.read(studyQnaControllerProvider.notifier).next();
  }

  Future<void> onToggleQnaItemBookmark(
      WidgetRef ref, SelectableQnaEntity<CommonQnaEntity> question) async {
    try {
      await ref
          .read(selectableQnasProvider(ref.read(selectedStudyTopicProvider).id)
              .notifier)
          .toggleBookmark(question);
    } catch (e) {
      // 에러 처리
      debugPrint('북마크 토글 실패: $e');
    }
  }

  ///
  /// 북마크 모아보기 필터 토글
  ///
  void onToggleBookmarkFilter(WidgetRef ref) =>
      ref.read(studyBookmarkFilterProvider.notifier).toggle();
}
