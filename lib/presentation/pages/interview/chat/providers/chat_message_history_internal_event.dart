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

    ref.invalidate(interviewRoomsProvider);
  }

  ///
  /// 가장 마지막 질문 채팅 메세지를 반환
  ///
  QuestionChatMessageEntity _getLastQuestionChat() {
    return state.requireValue
            .firstWhere((chat) => chat is QuestionChatMessageEntity)
        as QuestionChatMessageEntity;
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

    await update((previous) => chatList);
    await ref.read(chatQnasProvider.notifier).updateState(resolvedAnsweredChat);

    return resolvedAnsweredChat;
  }

  ///
  /// 초기 인트로 메시지와
  /// 처음으로 질문을 제시
  ///
  Future<void> _showIntroAndQuestionMessages() async {
    final introMessage = await createIntroMessage();
    await _showMessage(
      message: introMessage,
      onDone: () async {
        final questionMessage = await suggestNewQuestion();
        await createChatRoomUseCase(
          room: ref.read(selectedChatRoomProvider),
          messages: [questionMessage, introMessage],
          qnas: ref.read(chatQnasProvider).requireValue,
        );
      },
    );
  }
}
