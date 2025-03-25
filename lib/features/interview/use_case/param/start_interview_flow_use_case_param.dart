import 'dart:async';

import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

sealed class StartInterviewFlowBaseParam {
  StartInterviewFlowBaseParam(this.type);

  final InterviewType type;
}

///
/// 역량별 면접
///
class ProficiencyInterviewFlowParam extends StartInterviewFlowBaseParam {
  ProficiencyInterviewFlowParam({
    required this.topicSelectionCompleter,
    required this.levelSelectionCompleter,
    required this.questionCountCompleter,
    required this.createdQnasCompleter,
  }) : super(InterviewType.proficiency); // 부모 클래스 생성자 호출

  // Completer (단계별 선택 완료 시 결과 저장)
  final Completer<List<TechSetEntity>?> topicSelectionCompleter;
  final Completer<InterviewLevel?> levelSelectionCompleter;
  final Completer<int?> questionCountCompleter;
  final Completer<List<ProficiencyQnaEntity>?> createdQnasCompleter;

  factory ProficiencyInterviewFlowParam.initial() {
    return ProficiencyInterviewFlowParam(
      topicSelectionCompleter: Completer(),
      levelSelectionCompleter: Completer(),
      questionCountCompleter: Completer(),
      createdQnasCompleter: Completer(),
    );
  }

  ProficiencyInterviewFlowParam copyWith({
    Completer<List<TechSetEntity>?>? topicSelectionCompleter,
    Completer<InterviewLevel?>? levelSelectionCompleter,
    Completer<int?>? questionCountCompleter,
    Completer<List<ProficiencyQnaEntity>?>? createdQnasCompleter,
  }) {
    return ProficiencyInterviewFlowParam(
      topicSelectionCompleter:
          topicSelectionCompleter ?? this.topicSelectionCompleter,
      levelSelectionCompleter:
          levelSelectionCompleter ?? this.levelSelectionCompleter,
      questionCountCompleter:
          questionCountCompleter ?? this.questionCountCompleter,
      createdQnasCompleter: createdQnasCompleter ?? this.createdQnasCompleter,
    );
  }

  @override
  String toString() {
    return 'ProficiencyInterviewFlowParam{topicSelectionCompleter: $topicSelectionCompleter, levelSelectionCompleter: $levelSelectionCompleter, questionCountCompleter: $questionCountCompleter}';
  }
}
