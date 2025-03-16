import 'dart:async';

import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

sealed class StartInterviewFlowBaseParam {
  StartInterviewFlowBaseParam(this.type);

  final InterviewType type;
}

class ProficiencyInterviewFlowParam extends StartInterviewFlowBaseParam {
  final Completer<List<TechSetEntity>?> topicSelectionCompleter;
  final Completer<InterviewLevel?> levelSelectionCompleter;

  ProficiencyInterviewFlowParam({
    required this.topicSelectionCompleter,
    required this.levelSelectionCompleter,
  }) : super(InterviewType.proficiency);

  factory ProficiencyInterviewFlowParam.initial() =>
      ProficiencyInterviewFlowParam(
        topicSelectionCompleter: Completer(),
        levelSelectionCompleter: Completer(),
      );

  ProficiencyInterviewFlowParam copyWith({
    Completer<List<TechSetEntity>?>? topicSelectionCompleter,
    Completer<InterviewLevel?>? levelSelectionCompleter,
  }) {
    return ProficiencyInterviewFlowParam(
      topicSelectionCompleter: topicSelectionCompleter ?? Completer(),
      levelSelectionCompleter: levelSelectionCompleter ?? Completer(),
    );
  }
}
