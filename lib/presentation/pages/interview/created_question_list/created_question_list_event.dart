import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/route_extension.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/created_question_list_rout_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/listed_selectable_qnas_provider.dart';
import 'package:techtalk/core/services/slack_notification_service.dart' as noti;

mixin class CreatedQuestionListEvent {
  ///
  /// 문답 박스가 클릭 되었을 때
  /// 선택 여부 토글
  ///
  void onQnaBoxTapped(WidgetRef ref, {required SelectableQnaEntity qna}) {
    return ref.read(listedSelectableQnasProviderProvider.notifier).toggle(qna);
  }

  ///
  /// 면접 시작하기 버튼이 클릭 되었을 때
  ///
  Future<void> onStartInterviewBtnTapped(WidgetRef ref) async {
    final useCaseParam = ref
        .read(createdQuestionListRouteArgProvider)
        .useCaseParma as ProficiencyInterviewFlowParam;

    final qnas = (await ref.read(listedSelectableQnasProviderProvider.future))
        .where((e) => e.isSelected)
        .map((e) => e.qna as ProficiencyQnaEntity)
        .toList()
      ..shuffle();

    final level = await useCaseParam.levelSelectionCompleter.future;
    if (qnas.isEmpty) {
      GoRouter.of(ref.context).popUntilPath(MainRoute.path);
      return;
    }
    final room = ChatRoomEntity.generateProficiencyInterview(
      qnas: qnas,
      level: level,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    GoRouter.of(ref.context).popUntilPath(MainRoute.path);
    unawaited(
      noti.SlackNotificationService.sendNotification(
        type: SlackNotificationType.event,
        message:
            '역량별 면접이 시작되었어요! 면접 개수 : ${qnas.length} / 면접 주제 : ${qnas.map((e) => e.techSet.name).toSet().join(', ')}',
      ),
    );
    route.push(ref.context);
  }
}
