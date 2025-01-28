part of 'chat_message_history_provider.dart';

///
/// 단골질문 관련 provider event
///
extension ChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 꼬리질문 생성
  ///
  Future<QuestionChatEntity?> _startFollowUpQuestion({
    required List<BaseChatEntity> chatHistory,
    required FeedbackResponseEntity rootFeedbackResponse,
    required AnswerChatEntity rootAnswerChat,
  }) async {
    log('👀: 피드백 필요함!!!!!!');

    final feedbackChat = FeedbackChatEntity.createStatic(
      message: rootFeedbackResponse.feedback,
      timestamp: DateTime.now(),
      qnaId: rootFeedbackResponse.topicQuestion.qna.id,
    );

    /// NOTE
    /// 꼬리질문 id 형태
    /// "rootQnaId=난수"
    final followUpQuestionId =
        '${rootFeedbackResponse.topicQuestion.qna.id}=${const Uuid().v1()}';

    QuestionChatEntity? followUpQuestionChat;

    final response = SetAiFollowUpQuestionUseCase().call((
      interviewType: ref.read(selectedChatRoomProvider).type,
      chatHistory: chatHistory,
      youtubeExtra: ref.read(selectedChatRoomProvider).youtubeExtra,
      onFollowUpQuestionCompleted: ({required String followUpQuestion}) async {
        followUpQuestionChat = QuestionChatEntity.createStatic(
          qnaId: followUpQuestionId,
          rootQnaId: rootFeedbackResponse.topicQuestion.qna.id,
          message: followUpQuestion,
          timestamp: DateTime.now(),
        );

        await _uploadMessage([
          rootAnswerChat,
          feedbackChat,
          followUpQuestionChat!,
        ]).then(
          /// 꼬리 질문 제시 이전 root Qna 프로스세 정보 업데이트
          (_) => ref.read(selectedChatRoomProvider.notifier).updateProgressInfo(
                isCorrect: rootAnswerChat.answerState.isCorrect,
                lastChatMessage: followUpQuestionChat!,
                updateTotalCount: true,
              ),
        );
      },
      rootQna: rootFeedbackResponse.topicQuestion,
      userName: rootFeedbackResponse.userName,
      onError: _onAiFeedbackErrorOccured,
    ));

    await response.fold(
      onSuccess: (questionStreamChat) async {
        /// 3) 유저 답변에 대한 피드백 채팅 전달
        await showMessage(
          message: QuestionChatEntity(
            message: questionStreamChat,
            qnaId: followUpQuestionId,
            rootQnaId: rootFeedbackResponse.topicQuestion.qna.id,
          ),
        );
      },
      onFailure: (e) {
        logger.e(e);
        _rollbackToPreviousChatStep();
        SnackBarService.showSnackBar(
            '정답 여부를 판별하는 과정에서 오류가 발생했습니다. 잠시후 다시 시도해주세요.');
      },
    );

    return followUpQuestionChat;
  }

  ///
  /// 채팅 메세지 상태 업데이트
  ///
  Future<void> showMessage({
    required BaseChatEntity message,
    void Function()? onDone,
  }) async {
    unawaited(HapticFeedback.lightImpact());
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
        message.isStreamApplied = false;
      },
    );
  }

  ///
  /// 채팅 메세지 데이터를 서버에 업로드
  ///
  Future<void> _uploadMessage(List<BaseChatEntity> messages) async {
    final interviewType = ref.read(selectedChatRoomProvider).type;
    if (interviewType.isYoutube) return;
    await createChatMessagesUseCase(
      messages: messages,
      chatRoomId: ref.read(selectedChatRoomProvider).id,
    );
  }

  ///
  /// 유저 답변 메세지 정답 여부를 확인하고
  /// 상태를 업데이트
  ///
  Future<AnswerChatEntity> _updateUserAnswerState({
    required AnswerState answerState,
    required List<BaseChatEntity> targetChatHistory,
  }) async {
    final chatList = state.requireValue.toList();

    final answeredChat = targetChatHistory
        .lastWhere((chat) => chat.type.isSentMessage) as AnswerChatEntity;

    final followUpQna =
        targetChatHistory.whereType<QuestionChatEntity>().toList().last;

    final resolvedAnsweredChat = answeredChat.copyWith(
      answerState: answerState,
      followUpQuestion: followUpQna.message.value,
      qnaId: followUpQna.isFollowUpQuestion ? followUpQna.qnaId : null,
      // followUpQuestion: followUpQna.message.value,
    );
    final targetIndex = chatList.indexWhere((chat) => chat == answeredChat);

    chatList[targetIndex] = resolvedAnsweredChat;

    await update((_) => chatList);

    await ref.read(chatQnasProvider.notifier).updateState(resolvedAnsweredChat);

    return resolvedAnsweredChat;
  }

  ///
  /// 새로운 Qna 추출
  ///
  ChatQnaEntity? _getNewQna() {
    var qna = ref
        .read(chatQnasProvider)
        .requireValue
        .firstWhereOrNull((qna) => !qna.hasUserResponded);

    /// TODO
    /// 비동기 순서가 꼬여서 아직 제시할 질문이 하나가 남았지만
    /// 이미 응답이 완료되었기 때문에 마지막 질문을 못가져오는 경우가 잇음
    /// 이런 경우 마지막 질문을 리턴함
    /// 추후에 근본적인 해결 방법 필요
    // qna ??= ref.read(chatQnasProvider).requireValue.first;

    return qna;
  }

  ///
  /// AI 응답 과정에서 에러 발생했을 때 실행하는 프로세스
  ///
  void _onAiFeedbackErrorOccured([Object? error, StackTrace? startTrace]) {
    logger.e('에러 발생 : $error');
    _rollbackToPreviousChatStep();
    SnackBarService.showSnackBar(
        tr(LocaleKeys.interview_aiFeedbackErrorOccured));

    /// NOTE 임시 주석
    // await _rollbackToPreviousChatStep();
    // final context = rootNavigatorKey.currentContext!;
    // DialogService.show(
    //     dialog: AppDialog.singleBtn(
    //       btnContent: context.tr(LocaleKeys.common_confirm),
    //       title: context.tr(LocaleKeys.common_errorDetectedTryLater),
    //       onBtnClicked: () async {
    //         context.pop();
    //         context.pop();
    //       },
    //     ));
  }

  ///
  /// 가장 최근 유저가 질문에 답변하기 이전의 채팅 상태로 롤백
  ///
  Future<void> _rollbackToPreviousChatStep() async {
    final chatList = state.requireValue;

    final targetIndex =
        chatList.indexWhere((chat) => chat.type.isQuestionMessage);

    await update((previous) {
      return [...chatList.sublist(targetIndex, chatList.length)];
    });
  }
}
