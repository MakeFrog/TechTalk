import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/route_extension.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/constant/created_question_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/created_proficiency_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/question_creation_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/question_creation_state.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/services/slack_notification_service.dart' as noti;

mixin class QuestionCreationEvent {
  ///
  /// 면접 시작하기 버튼이 클릭 되었을 때
  ///
  Future<void> onStartInterViewBtnTapped(WidgetRef ref) async {
    final useCaseParam = ref.read(questionCreationRouteArgProvider).useCaseParam
        as ProficiencyInterviewFlowParam;
    final qnas = await useCaseParam.createdQnasCompleter.future;
    final level = await useCaseParam.levelSelectionCompleter.future;
    if (qnas?.isEmpty ?? true) {
      GoRouter.of(ref.context).popUntilPath(MainRoute.path);
      return;
    }
    final room = ChatRoomEntity.generateProficiencyInterview(
      qnas: qnas!,
      level: level,
    );

    unawaited(
      noti.SlackNotificationService.sendNotification(
        type: SlackNotificationType.event,
        message:
            '역량별 면접이 시작되었어요! 면접 개수 : ${qnas.length} / 면접 주제 : ${qnas.map((e) => e.techSet.name).toSet().join(', ')}',
      ),
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.pushReplacement(ref.context);
  }

  ///
  /// '질문 고르기' 버튼이 클릭 되었을 때
  ///
  Future<void> routeToListedQnasPage(WidgetRef ref) async {
    final arg = CreatedQuestionListRouteArg(
        ref.read(questionCreationRouteArgProvider).useCaseParam);
    unawaited(CreatedQuestionListRoute(arg).push(ref.context));
  }

  ///
  /// 면접 질문이 생성되면 [StartInterviewFlowBaseParam] completer 초기화
  ///
  Future<void> setQnaCompleter(WidgetRef ref) async {
    final targetUseCaseParam = ref
        .read(questionCreationRouteArgProvider)
        .useCaseParam as ProficiencyInterviewFlowParam;

    final createdQnas = await ref
        .read(createdProficiencyQnasProvider(targetUseCaseParam).future);
    (ref.read(questionCreationRouteArgProvider).useCaseParam
            as ProficiencyInterviewFlowParam)
        .createdQnasCompleter
        .complete(createdQnas);
  }

  ///
  /// 백버튼이 클릭 되었을 때
  ///
  void onBackBtnTapped(WidgetRef ref) {
    final isQuestionCreated = QuestionCreationState().hasQuestionCreated(ref);

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        showContentImg: false,
        title: isQuestionCreated
            ? tr(LocaleKeys.interview_questionCreation_event_readyToStart)
            : tr(LocaleKeys
                .interview_questionCreation_event_generatingQuestions),
        description: isQuestionCreated
            ? tr(LocaleKeys
                .interview_questionCreation_event_readyToStartDescription)
            : tr(LocaleKeys
                .interview_questionCreation_event_generatingQuestionsDescription),
        leftBtnContent: tr(LocaleKeys.common_exit),
        rightBtnContent: isQuestionCreated
            ? tr(LocaleKeys.interview_questionCreation_event_startInterview)
            : tr(LocaleKeys.interview_questionCreation_event_continueInterview),
        onRightBtnClicked: () {
          if (!isQuestionCreated &&
              QuestionCreationState().hasQuestionCreated(ref)) {
            ref.context.pop();
          } else {
            ref.context.pop();
            onStartInterViewBtnTapped(ref);
          }
        },
        onLeftBtnClicked: () {
          if (!isQuestionCreated &&
              QuestionCreationState().hasQuestionCreated(ref)) {
            SnackBarService.showSnackBar(tr(LocaleKeys
                .interview_questionCreation_event_questionsJustCreated));
            ref.context.pop();
          } else {
            GoRouter.of(ref.context).popUntilPath(MainRoute.path);
          }
        },
      ),
    );
  }

  String get startInterviewText =>
      tr(LocaleKeys.interview_questionCreation_event_startInterview);
  String get selectQuestionText =>
      tr(LocaleKeys.interview_questionCreation_event_selectQuestion);
  String get deselectQuestionText =>
      tr(LocaleKeys.interview_questionCreation_event_deselectQuestion);
}
