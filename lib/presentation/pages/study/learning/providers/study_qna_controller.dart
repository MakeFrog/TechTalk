import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/riverpod_extension.dart';

part 'study_qna_controller.g.dart';

@riverpod
class StudyQnaController extends _$StudyQnaController {
  final _qnaAnimationDuration = 400.ms;
  final _qnaAnimationCurves = Curves.easeOutQuint;

  @override
  Raw<PageController> build() {
    return ref.autoDisposeChangeNotifier(
      PageController(),
    );
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
