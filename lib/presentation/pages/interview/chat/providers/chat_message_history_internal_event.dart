part of 'chat_message_history_provider.dart';

extension ChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 꼬리질문 생성
  ///
  Future<QuestionChatEntity?> _startFollowUpQuestion({
    required List<BaseChatEntity> chatHistory,
    required FeedbackResponseEntity feedbackResponse,
    required AnswerChatEntity answerChat,
  }) async {
    log('👀: 피드백 필요함!!!!!!');

    final feedbackChat = FeedbackChatEntity.createStatic(
      message: feedbackResponse.feedback,
      timestamp: DateTime.now(),
      qnaId: feedbackResponse.topicQuestion.qna.id,
    );

    /// NOTE
    /// 꼬리질문 id 형태
    /// "rootQnaId=난수"
    final followUpQuestionId =
        '${feedbackResponse.topicQuestion.qna.id}=${const Uuid().v1()}';

    QuestionChatEntity? followUpQuestionChat;

    final response = SetAiFollowUpQuestionUseCase().call((
      chatHistory: chatHistory,
      onFollowUpQuestionCompleted: ({required String followUpQuestion}) async {
        followUpQuestionChat = QuestionChatEntity.createStatic(
          qnaId: followUpQuestionId,
          rootQnaId: feedbackResponse.topicQuestion.qna.id,
          message: followUpQuestion,
          timestamp: DateTime.now(),
        );

        await _uploadMessage([
          answerChat,
          feedbackChat,
          followUpQuestionChat!,
        ]).then(
          /// 꼬리 질문 제시 이전 root Qna 프로스세 정보 업데이트
          (_) => ref.read(selectedChatRoomProvider.notifier).updateProgressInfo(
                isCorrect: answerChat.answerState.isCorrect,
                lastChatMessage: followUpQuestionChat!,
                isRootQuestion: true,
              ),
        );
      },
      rootQna: feedbackResponse.topicQuestion,
      userName: feedbackResponse.userName,
    ));

    await response.fold(
      onSuccess: (questionStreamChat) async {
        /// 3) 유저 답변에 대한 피드백 채팅 전달
        await showMessage(
          message: QuestionChatEntity(
            message: questionStreamChat,
            qnaId: followUpQuestionId,
            rootQnaId: feedbackResponse.topicQuestion.qna.id,
          ),
        );
      },
      onFailure: (e) {
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
  }) async {
    final chatList = state.requireValue.toList();

    final answeredChat = chatList.firstWhere((chat) => chat.type.isSentMessage)
        as AnswerChatEntity;

    final resolvedAnsweredChat = answeredChat.copyWith(
      answerState: answerState,
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

    final nickname = ref.watch(userInfoProvider).requireValue!.nickname!;
    final firstQna = _getNewQna();
    final String introMessage;

    if (room.type.isSingleTopic) {
      introMessage = rootNavigatorKey.currentContext!.tr(
        LocaleKeys.undefined_greetingMessageSingleTopic,
        namedArgs: {
          'nickname': nickname,
          'topic': room.topics.first.text,
        },
      );
    } else {
      introMessage = rootNavigatorKey.currentContext!.tr(
        LocaleKeys.undefined_greetingMessageMultipleTopics,
        namedArgs: {
          'nickname': nickname,
          'firstTopic':
              StoredTopics.getById(firstQna.qna.id.getFirstPartOfSpliited).text,
        },
      );
    }

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

  ///
  /// 새로운 Qna 추출
  ///
  ChatQnaEntity _getNewQna() {
    var qna = ref
        .read(chatQnasProvider)
        .requireValue
        .firstWhereOrNull((qna) => !qna.hasUserResponded);

    /// TODO
    /// 비동기 순서가 꼬여서 아직 제시할 질문이 하나가 남았지만
    /// 이미 응답이 완료되었기 때문에 마지막 질문을 못가져오는 경우가 잇음
    /// 이런 경우 마지막 질문을 리턴함
    /// 추후에 근본적인 해결 방법 필요
    qna ??= ref.read(chatQnasProvider).requireValue.first;

    return qna;
  }

  ///
  /// 가장 최근 유저가 질문에 답변하기 이전의 채팅 상태로 롤백
  ///
  Future<void> _rollbackToPreviousChatStep() async {
    final chatList = state.requireValue;

    final targetIndex =
        chatList.firstIndexWhereOrNull((chat) => chat.type.isQuestionMessage);

    await update((previous) {
      return [...chatList.sublist(targetIndex!, chatList.length - 1)];
    });
  }
}
