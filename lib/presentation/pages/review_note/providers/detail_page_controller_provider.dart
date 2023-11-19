import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_page_controller_provider.g.dart';

@riverpod
class DetailPageController extends _$DetailPageController {
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

  set initPage(int index) {
    state.jumpToPage(index);
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
