part of 'chat_message_history_provider.dart';

///
/// 이력서(+포트폴리오) 면접
/// [ChatMessageHistory] 내부 event + notifier 메소드
///
extension ResumeTypeChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 초기 인트로 메시지와
  /// 처음으로 질문을 제시
  ///

  Future<void> _showProficiencyTypeIntroMessages() async {
    final InterviewLevel interviewLevel =
        ref.read(selectedChatRoomProvider).interviewLevel;
    final userName =
        (await ref.read(userInfoProvider.future))?.nickname ?? '익명';

    final firstQna = _getNewQna()!;

    final String introMessage =
        '반가워요! $userName님 ${interviewLevel.titleLabel} 역량에 맞는 면접 질문을 제시해드릴게요';

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
