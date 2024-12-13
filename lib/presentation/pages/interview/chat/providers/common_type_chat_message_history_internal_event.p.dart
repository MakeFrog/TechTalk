part of 'chat_message_history_provider.dart';

///
/// 단골질문 > 내부 메소드
///
extension CommonTypeChatMessageHistoryInternalEvent on ChatMessageHistory {
  ///
  /// 초기 인트로 메시지와
  /// 처음으로 질문을 제시
  ///
  Future<void> _showIntroAndCommonQuestionMessages() async {
    final room = ref.read(selectedChatRoomProvider);

    final nickname = ref.watch(userInfoProvider).requireValue!.nickname!;
    final firstQna = _getNewQna()!;
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
}
