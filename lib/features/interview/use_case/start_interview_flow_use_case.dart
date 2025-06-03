import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/constant/interview_level_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/constant/proficiency_interview_topic_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/constant/select_question_count_route_argument.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/constant/question_creation_route_arg.dart';

/// AI 모의 면접 플로우를 관리하는 UseCase
///
/// 지원하는 면접 유형:
/// 1. 단골 면접
///    - 주제별 면접
///    - 실전 면접
/// 2. 역량 면접
/// 3. 기타 추가될 면접 유형
///
/// 각 면접 유형별로 필요한 파라미터는 [StartInterviewFlowBaseParam]에 정의되어 있으며,
/// 현재는 [ProficiencyInterviewFlowParam]만 지원합니다.
final class StartInterviewFlowUseCase {
  StartInterviewFlowUseCase(this._interviewFlowParam);

  late BuildContext _context;
  final ProficiencyInterviewFlowParam _interviewFlowParam;

  /// 역량 면접 플로우를 진행합니다.
  ///
  /// 진행 순서:
  /// 1. 면접 주제 선택
  /// 2. 면접 난이도 선택
  /// 3. 문제 개수 선택
  /// 4. 면접 질문 생성 페이지 (로딩)
  Future<void> executeProficiencyInterviewFlow() async {
    _context = await navigationContext;

    // 1. 면접 주제 선택
    if (!_interviewFlowParam.topicSelectionCompleter.isCompleted) {
      _navigateToTopicSelection();
    }

    final selectedTopics =
        await _interviewFlowParam.topicSelectionCompleter.future;
    if (selectedTopics == null || selectedTopics.isEmpty) {
      logger.i('면접 주제 선택이 취소되었습니다');
      return;
    }

    // 2. 면접 난이도 선택
    if (!_interviewFlowParam.levelSelectionCompleter.isCompleted) {
      _navigateToLevelSelection();
    }

    final selectedLevel =
        await _interviewFlowParam.levelSelectionCompleter.future;
    if (selectedLevel == null) {
      logger.i('면접 난이도 선택이 취소되었습니다');
      return;
    }

    // 3. 문제 개수 선택
    if (!_interviewFlowParam.questionCountCompleter.isCompleted) {
      _navigateToQuestionCountSelection();
    }

    final selectedQuestionCount =
        await _interviewFlowParam.questionCountCompleter.future;
    if (selectedQuestionCount == null) {
      logger.i('문제 개수 선택이 취소되었습니다');
      return;
    }

    _navigateToQuestionCreation();
  }

  /// 면접 주제 선택 페이지로 이동
  void _navigateToTopicSelection() {
    final routeArgument =
        ProficiencyInterviewTopicSelectionRouteArgument(_interviewFlowParam);
    ProficiencyInterviewTopicSelectionRoute(routeArgument).push(_context);
  }

  /// 면접 난이도 선택 페이지로 이동
  void _navigateToLevelSelection() {
    final routeArgument = InterviewLevelSelectionRouteArg(_interviewFlowParam);

    InterviewLevelSelectionRoute(routeArgument)
        .push(_context)
        .whenComplete(() async {
      if (!_interviewFlowParam.levelSelectionCompleter.isCompleted) {
        _interviewFlowParam.levelSelectionCompleter.complete(null);
      }
    });
  }

  /// 문제 개수 선택 페이지로 이동
  void _navigateToQuestionCountSelection() {
    final routeArgument = SelectQuestionCountRouteArg(
      useCaseParam: _interviewFlowParam,
      interviewType: InterviewType.proficiency,
      topics: [],
    );

    QuestionCountSelectPageRoute(routeArgument).push(_context).whenComplete(() {
      if (!_interviewFlowParam.questionCountCompleter.isCompleted) {
        _interviewFlowParam.questionCountCompleter.complete(null);
      }
    });
  }

  /// 면접 질문 생성 페이지로 이동
  void _navigateToQuestionCreation() {
    final routeArgument = QuestionCreationRouteArg(_interviewFlowParam);
    QuestionCreationRoute(routeArgument).go(_context);
  }
}
