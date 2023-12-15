import 'package:flutter/cupertino.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_progress_info_entity.dart';
import 'package:techtalk/features/shared/enums/interviewer_avatar.dart';

abstract class _ChatListEvent {
  /// 채팅 페이지로 이동
  void routeToChatPage(BuildContext context,
      {required InterviewProgressState progressState,
      required ChatQnaProgressInfoEntity qnaProgressInfo,
      required String roomId,
      required InterviewTopic topic,
      required InterviewerAvatar interviewer});
}

mixin class ChatListEvent implements _ChatListEvent {
  @override
  void routeToChatPage(BuildContext context,
      {required String roomId,
      required InterviewProgressState progressState,
      required ChatQnaProgressInfoEntity qnaProgressInfo,
      required InterviewTopic topic,
      required InterviewerAvatar interviewer}) {
    ChatPageRoute(
      progressState: progressState,
      roomId: roomId,
      topic: topic,
      $extra: ChatQnaProgressInfoEntity(
        totalQuestionCount: qnaProgressInfo.totalQuestionCount,
        correctAnswerCount: qnaProgressInfo.correctAnswerCount,
        incorrectAnswerCount: qnaProgressInfo.incorrectAnswerCount,
      ),
      interviewer: interviewer,
    ).go(context);
  }
}
