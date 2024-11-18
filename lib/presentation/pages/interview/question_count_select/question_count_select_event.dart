import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/slack_notification_type.enum.dart';
import 'package:techtalk/core/services/slack_notification_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';

mixin class QuestionCountSelectEvent {
  ///
  /// 채팅 페이지로 이동
  ///
  Future<void> routeToChatPage(
    WidgetRef ref, {
    required InterviewType type,
    required List<TopicEntity> topics,
  }) async {
    // 페이지 이동 및 채팅방 정보 조회 후 제거한다.
    await EasyLoading.show();

    final questionCount = ref.read(selectedQuestionCountProvider) +
        SelectedQuestionCount.defaultPlusCount;

    final room = ChatRoomEntity.random(
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
  /// 문제 개수가 변경 되었을 때
  ///
  void onCountOptionChanged(WidgetRef ref, {required int countOption}) =>
      ref.read(selectedQuestionCountProvider.notifier).update(countOption);
}
