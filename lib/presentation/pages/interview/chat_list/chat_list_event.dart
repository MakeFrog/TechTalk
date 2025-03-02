import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

mixin class ChatListEvent {
  /// 채팅 페이지로 이동
  void routeToChatPage(
    BuildContext context, {
    required ChatRoomEntity room,
  }) {
    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.push(context);
  }

  /// 면접 질문 갯수 선택 페이지로 이동
  void routeToQuestionCountSelectPage(
    WidgetRef ref, {
    required TopicEntity topic,
  }) {
    const type = InterviewType.commonSingleTopic;

    final route = QuestionCountSelectPageRoute(
      type,
      topic.id,
    );

    route.updateArg(type: type, topics: [topic]);
    route.push(ref.context);
  }

  ///
  /// 면접 주제 페이지로 이동
  ///
  void routeToTopicSelectPage(WidgetRef ref) {
    InterviewTopicSelectRoute(
      InterviewType.commonPracticalTopic,
    ).push(ref.context);
  }

  ///
  /// 이력서 면접 업로드 페이지로 이동
  ///
  void routeToResumeUploadPage(WidgetRef ref) {
    const ResumeUploadRoute(
      InterviewType.resume,
    ).push(ref.context);
  }

  ///
  /// 이력서 관리 페이지로 이동
  ///
  void routeToResumeManagePage(WidgetRef ref) {
    const ResumeManageRoute().push(ref.context);
  }
}
