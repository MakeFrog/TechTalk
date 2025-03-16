import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/constant/interview_level_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/constant/proficiency_interview_topic_selection_route_arg.dart';

///
///  AI 모의 면접 flow 진입 flow
///
final class StartInterviewFlowUseCase {
  late BuildContext context;
  final StartInterviewFlowBaseParam param;

  StartInterviewFlowUseCase(this.param);

  Future<void> proficiencyInterview() async {
    final targetParam = param as ProficiencyInterviewFlowParam;
    context = await navigationContext;

    if (!targetParam.topicSelectionCompleter.isCompleted) {
      _routeToTopicSelection();
    }

    final topicSelectionResult =
        await targetParam.topicSelectionCompleter.future;

    if (topicSelectionResult == null || topicSelectionResult.isEmpty) {
      return;
    }

    if (!targetParam.levelSelectionCompleter.isCompleted) {
      _routeToLevelSelection();
    }

    final levelSelectionResult =
        await targetParam.levelSelectionCompleter.future;

    if (levelSelectionResult == null) {
      return;
    }
  }

  ///
  /// 주제 선택 화면으로 이동
  ///
  void _routeToTopicSelection() {
    final targetParam = param as ProficiencyInterviewFlowParam;
    final argument =
        ProficiencyInterviewTopicSelectionRouteArgument(targetParam);

    ProficiencyInterviewTopicSelectionRoute(argument).push(context);
  }

  ///
  /// 레벨 선택 화면으로 이동
  ///
  void _routeToLevelSelection() {
    final targetParam = param as ProficiencyInterviewFlowParam;
    final arg = InterviewLevelSelectionRouteArg(targetParam);

    InterviewLevelSelectionRoute(arg).push(context);
  }
}
