import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/core/services/slack_notification_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/interview/use_case/start_interview_flow_use_case.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/select_question_count_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/constant/select_common_question_route_arg.dart';

mixin class QuestionCountSelectEvent {
  ///
  /// 하단 '확인' 버튼이 클릭 되었을 때
  ///
  Future<void> onConfirmBtnTapped(
    WidgetRef ref, {
    required InterviewType type,
    required List<TopicEntity> topics,
  }) async {
    final arg = ref.read(selectedQuestionCountRouteArgProvider).useCaseParam;

    final questionCount = ref.read(selectedQuestionCountProvider) +
        SelectedQuestionCount.defaultPlusCount;

    if (arg?.type.isProficiency ?? false) {
      final useCaseParam = arg as ProficiencyInterviewFlowParam;
      if (useCaseParam.questionCountCompleter.isCompleted) {
        final targetParam = useCaseParam.copyWith(
            questionCountCompleter: Completer()..complete(questionCount));
        await StartInterviewFlowUseCase(targetParam)
            .executeProficiencyInterviewFlow();
      } else {
        useCaseParam.questionCountCompleter.complete(questionCount);
      }

      return;
    }

    /// ================ 기존 flow (단골면접) ===============
    /// 이후에 [StartInterviewFlowUseCase]에 통합 작업 필요

    // return;
    // 페이지 이동 및 채팅방 정보 조회 후 제거한다.
    await EasyLoading.show();

    final room = ChatRoomEntity.generateCommonInterview(
      type: type,
      topics: topics,
      questionCount: questionCount,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);

    route.updateArg(room: room);
    route.go(ref.context);

    unawaited(SlackNotificationService.sendNotification(
        type: SlackNotificationType.event,
        message:
            '면접을 새롭게 시작했어요 (${topics.map((e) => e.text)}/개수$questionCount)'));

    await EasyLoading.dismiss();
  }

  ///
  /// 하단 '문제 고르기' 버튼이 클릭 되었을 때
  ///
  Future<void> onSelectQuestionsBtnTapped(WidgetRef ref) async {
    final arg = ref.read(selectedQuestionCountRouteArgProvider);

    final routeArg = SelectCommonQuestionRouteArg(topics: arg.topics);

    final result = await SelectCommonQuestionRoute(routeArg).push(ref.context);

    if (result == true) {
      ref.read(selectedQuestionCountProvider.notifier).update(0);
    }
  }

  ///
  /// 문제 개수가 변경 되었을 때
  ///
  void onCountOptionChanged(WidgetRef ref, {required int countOption}) =>
      ref.read(selectedQuestionCountProvider.notifier).update(countOption);
}
