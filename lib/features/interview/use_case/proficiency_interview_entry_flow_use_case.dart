import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/constant/proficiency_interview_topic_selection_route_arg.dart';

///
/// 역량별 AI 면접 flow 진입 Flow
///
final class ProficiencyInterviewEntryFlowUseCase {
  late BuildContext context;
  Completer<List<TopicEntity>?> topicSelectionCompleter =
      Completer<List<TopicEntity>?>();

  Future<void> start() async {
    context = await navigationContext;

    await _routeToTopicSelection(topicSelectionCompleter);

    final topicSelectionResult = await topicSelectionCompleter.future;

    if (topicSelectionResult == null || topicSelectionResult.isEmpty) {
      return;
    }
  }

  Future<void> _routeToTopicSelection(
      Completer<List<TopicEntity>?> topicSelectionCompleter) async {
    final argument = ProficiencyInterviewTopicSelectionRouteArgument(
        topicSelectionCompleter);
    await ProficiencyInterviewTopicSelectionRoute(argument).push(context);
  }
}
