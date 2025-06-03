import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/route_extension.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/constant/created_question_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/created_proficiency_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/provider/question_creation_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_creation/question_creation_state.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

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

    if (isQuestionCreated) {
    } else {
      DialogService.show(
        dialog: AppDialog.dividedBtn(
          showContentImg: false,
          title: '질문을 만드는 중이에요!',
          description: '지금 나가면 면접을 위한 질문이 사라질 수 있어요\n정말 나가시겠어요?',
          leftBtnContent: '나가기',
          rightBtnContent: '면접 진행하기',
          onRightBtnClicked: () {
            ref.context.pop();
          },
          onLeftBtnClicked: () {
            if (QuestionCreationState().hasQuestionCreated(ref)) {
              SnackBarService.showSnackBar('잠깐! 방금 질문이 생성 되었어요');
              ref.context.pop();
            } else {
              GoRouter.of(ref.context).popUntilPath(MainRoute.path);
            }
          },
        ),
      );
    }
  }
}
