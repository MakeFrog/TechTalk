import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/select_common_question_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/select_common_question_state.dart';
import 'package:techtalk/presentation/providers/topic/selectable_common_qnas_provider.dart';

mixin class SelectCommonQuestionEvent {
  /// TechSet 선택 시 이벤트
  void onTechSetSelected(WidgetRef ref, {required TopicEntity targetTopic}) {
    final arg = ref.read(selectCommonQuestionRouteArgProvider).topics.first;
    ref.read(selectedInterviewTopicProvider(arg).notifier).update(targetTopic);
  }

  /// 질문 북마크 토글 이벤트
  void onQnaBoxTapped(
    WidgetRef ref, {
    required SelectableQnaEntity<CommonQnaEntity> qna,
  }) {
    final topic = SelectCommonQuestionState().selectedTopic(ref);
    ref
        .read(selectableCommonQnasProvider(topic.id).notifier)
        .toggleBookmark(qna);
  }

  ///
  /// 북마크된 모두 qna 선택
  ///
  void selectAllBookMarkedQnas(WidgetRef ref) {
    final topic = SelectCommonQuestionState().selectedTopic(ref);
    final provider = ref.read(selectableCommonQnasProvider(topic.id).notifier);

    if (provider.bookMarkedQnaIds.isEmpty) {
      SnackBarService.showSnackBar('북마크된 질문이 없어요');
      return;
    }

    provider.selectAllBookMarkedQnas();
  }

  ///
  /// 면접 시작 버튼 클릭 시 이벤트
  ///
  Future<void> onStartInterviewBtnTapped(WidgetRef ref) async {
    final selectedQnas = SelectCommonQuestionState().selectedQnas(ref);
    final topics = SelectCommonQuestionState().topics(ref);

    final room = ChatRoomEntity.generateCommonInterview(
      type: topics.length == 1
          ? InterviewType.commonSingleTopic
          : InterviewType.commonPracticalTopic,
      topics: topics,
      qnas: selectedQnas.map((e) => e.qna as CommonQnaEntity).toList(),
      questionCount: selectedQnas.length,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);

    route.updateArg(room: room);
    route.go(ref.context);
  }
}
