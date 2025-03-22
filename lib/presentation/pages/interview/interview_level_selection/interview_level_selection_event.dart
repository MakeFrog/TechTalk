import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/interview/use_case/start_interview_flow_use_case.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/interview_level_selection_state.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/interview_level_selection_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/level_selection_page_view_controller.dart';

mixin class InterviewLevelSelectionEvent {
  ///
  /// 상,중,하 레벨 버튼이 클릭 되었을 때
  ///
  void onLevelBtnTapped(WidgetRef ref, {required int index}) {
    final controller = ref.read(levelSelectionPageViewControllerProvider);
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  ///
  /// '다음'이 클릭 되었을 때
  ///
  void onCompleteBtnTapped(WidgetRef ref) async {
    final arg = ref.read(interviewLevelSelectionRouteArgProvider);

    final index =
        InterviewLevelSelectionState().pageController(ref).page?.floor() ?? 1;

    final selectedLevel = InterviewLevel.values[index];

    switch (arg.useCaseParam) {
      case ProficiencyInterviewFlowParam():
        final targetParam = arg.useCaseParam as ProficiencyInterviewFlowParam;
        if (targetParam.levelSelectionCompleter.isCompleted) {
          final param = targetParam.copyWith(
            levelSelectionCompleter: Completer()..complete(selectedLevel),
            questionCountCompleter: Completer(),
          );

          await StartInterviewFlowUseCase(param)
              .executeProficiencyInterviewFlow();
        } else {
          targetParam.levelSelectionCompleter.complete(selectedLevel);
        }
    }
  }
}
