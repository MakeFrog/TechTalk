part of 'chat_message_history_provider.dart';

///
/// 유튜브 콘텐츠 면접
/// [ChatMessageHistory] 내부 event + notifier 메소드
///
extension YoutubeTypeChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 초기 인트로 메시지와
  /// 처음으로 질문을 제시
  ///
  Future<void> _showYoutubeTypeIntroMessages() async {
    final nickname = ref.watch(userInfoProvider).requireValue!.nickname!;
    final room = ref.read(selectedChatRoomProvider).youtubeExtra;
    final firstQna = _getNewQna()!;
    final String introMessage =
        '안녕하세요 $nickname님! \‘${room?.contentTitle}’ 콘텐츠를 기반으로 면접질문을 여쭤볼게요.';

    final introChat = GuideChatEntity.createStatic(
      message: introMessage,
      timestamp: DateTime.timestamp(),
    );

    final firstQuestionChat = QuestionChatEntity.createStatic(
      qnaId: firstQna.qna.id,
      rootQnaId: firstQna.qna.id,
      message: firstQna.qna.question,
      timestamp: DateTime.timestamp(),
    );

    unawaited(showMessage(
      message: introChat.overwriteToStream(),
      onDone: () {
        showMessage(
          message: firstQuestionChat.overwriteToStream(),
        );
      },
    ));
  }
}
