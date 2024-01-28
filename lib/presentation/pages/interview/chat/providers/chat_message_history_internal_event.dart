part of 'chat_message_history_provider.dart';

extension ChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 채팅 메세지 상태 업데이트
  ///
  Future<void> _showMessage({
    required ChatMessageEntity message,
    void Function()? onDone,
  }) async {
    await update(
      (previous) => [
        message,
        ...previous,
      ],
    );
    message.message.listen(
      null,
      onDone: () {
        onDone?.call();
        message.message.close();
      },
    );
  }

  ///
  /// 채팅 메세지 데이터를 서버에 업로드
  ///
  Future<void> _uploadMessage(List<ChatMessageEntity> messages) async {
    await createChatMessagesUseCase(
      messages: messages,
      chatRoomId: ref.read(selectedChatRoomProvider).id,
    );
  }

  ///
  /// 유저 답변 메세지 정답 여부를 확인하고
  /// 상태를 업데이트
  ///
  Future<AnswerChatMessageEntity> _updateUserAnswerState({
    required bool isCorrect,
  }) async {
    final chatList = state.requireValue.toList();

    final answeredChat = chatList.firstWhere((chat) => chat.type.isSentMessage)
        as AnswerChatMessageEntity;
    final resolvedAnsweredChat = answeredChat.copyWith(
      answerState: isCorrect ? AnswerState.correct : AnswerState.wrong,
    );
    final targetIndex = chatList.indexWhere((chat) => chat == answeredChat);
    chatList[targetIndex] = resolvedAnsweredChat;

    await update((_) => chatList);

    await ref.read(chatQnasProvider.notifier).updateState(resolvedAnsweredChat);

    return resolvedAnsweredChat;
  }

  ///
  /// 초기 인트로 메시지와
  /// 처음으로 질문을 제시
  ///
  Future<void> _showIntroAndQuestionMessages() async {
    final room = ref.read(selectedChatRoomProvider);
    final nickname = ref.read(userDataProvider).requireValue!.nickname!;
    final String introMessage =
        '반가워요! $nickname님. ${room.topics.first.text} 면접 질문을 드리겠습니다';

    final firstQna = _getNewQna();

    final introChat = GuideChatMessageEntity.createStatic(
      message: introMessage,
      timestamp: DateTime.timestamp(),
    );

    final firstQuestionChat = QuestionChatMessageEntity.createStatic(
      qnaId: firstQna.qna.id,
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
            (_) => ref
                .read(selectedChatRoomProvider.notifier)
                .updateInitialInfo(firstQuestionChat),
          ),
          _showMessage(
            message: introChat.overwriteToStream(),
            onDone: () {
              _showMessage(
                message: firstQuestionChat.overwriteToStream(),
              );
            },
          ),
        ],
      ),
    );
  }

  ///
  /// 새로운 Qna 추출
  ///
  ChatQnaEntity _getNewQna() {
    final qna = ref
        .read(chatQnasProvider)
        .requireValue
        .firstWhere((qna) => !qna.hasUserResponded);

    return qna;
  }
}