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
  Future<void> _showResumeTypeIntroMessages() async {
    final room = ref.read(selectedChatRoomProvider);

    final nickname = ref.watch(userInfoProvider).requireValue!.nickname!;
    final firstQna = _getNewQna()!;
    final String introMessage =
        '안녕하세요 $nickname님 제출해주신 이력서, 포트폴리오 기반으로 면접 질문을 전달해 드릴게요';

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

    unawaited(
      Future.wait(
        [
          createChatRoomUseCase(
            room: ref.read(selectedChatRoomProvider),
            messages: [firstQuestionChat, introChat],
            qnas: ref.read(chatQnasProvider).requireValue,
          ).then(
            (_) {
              ref
                  .read(selectedChatRoomProvider.notifier)
                  .updateInitialInfo(firstQuestionChat);
            },
          ),
          showMessage(
            message: introChat.overwriteToStream(),
            onDone: () {
              showMessage(
                message: firstQuestionChat.overwriteToStream(),
                onDone: () {
                  ref
                      .read(userInfoProvider.notifier)
                      .updateTopicRecordsOnCondition(room.topics);
                  if (room.type.isPractical) {
                    ref
                        .read(userInfoProvider.notifier)
                        .storeUserPracticalRecordExistInfo();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
