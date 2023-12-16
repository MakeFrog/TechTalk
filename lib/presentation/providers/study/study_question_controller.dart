import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_question_controller.g.dart';

@riverpod
class StudyQuestionController extends _$StudyQuestionController {
  final _qnaAnimationDuration = 400.ms;
  final _qnaAnimationCurves = Curves.easeOutQuint;

  @override
  Raw<PageController> build() {
    final controller = PageController();

    ref.onDispose(
      controller.dispose,
    );

    return controller;
  }

  void next() {
    state.nextPage(
      duration: _qnaAnimationDuration,
      curve: _qnaAnimationCurves,
    );
  }

  void prev() {
    state.previousPage(
      duration: _qnaAnimationDuration,
      curve: _qnaAnimationCurves,
    );
  }
}

@riverpod
int currentQuestionPage(CurrentQuestionPageRef ref) {
  try {
    return ref.watch(studyQuestionControllerProvider).page?.round() ?? 0;
  } catch (e) {
    return 0;
  }
}
