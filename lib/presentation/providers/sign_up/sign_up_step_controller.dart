import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/riverpod_extension.dart';

part 'sign_up_step_controller.g.dart';

@riverpod
class SignUpStepController extends _$SignUpStepController {
  final _pagingDuration = 500.ms;
  final _pagingCurve = Curves.easeOutExpo;

  @override
  Raw<PageController> build() {
    return ref.autoDisposeChangeNotifier(
      PageController(),
    );
  }

  void next() {
    state.nextPage(
      duration: _pagingDuration,
      curve: _pagingCurve,
    );
  }

  void prev() {
    state.previousPage(
      duration: _pagingDuration,
      curve: _pagingCurve,
    );
  }
}
