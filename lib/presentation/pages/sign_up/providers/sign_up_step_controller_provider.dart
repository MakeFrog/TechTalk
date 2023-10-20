import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_step_controller_provider.g.dart';

@riverpod
class SignUpStepController extends _$SignUpStepController {
  final _pagingDuration = 500.ms;
  final _pagingCurve = Curves.easeOutExpo;

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

@riverpod
class CanBackToPreviousStep extends _$CanBackToPreviousStep {
  void _listenController(PageController controller) {
    state = controller.hasClients && controller.page!.ceil() >= 1;
  }

  @override
  bool build() {
    final controller = ref.watch(signUpStepControllerProvider);

    controller.addListener(
      () => _listenController(controller),
    );

    ref.onDispose(() {
      controller.removeListener(
        () => _listenController(controller),
      );
    });

    return false;
  }
}
