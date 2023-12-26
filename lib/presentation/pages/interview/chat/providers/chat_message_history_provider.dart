import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_qnas_of_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/interview_rooms_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'chat_message_history_provider.g.dart';

@riverpod
class ChatMessageHistory extends _$ChatMessageHistory {
  @override
  FutureOr<List<ChatMessageEntity>> build(ChatRoomEntity room) async {
    ref.listenSelf((previous, next) {
      // 처음 채팅방에 진입한 경우
      if (next.hasValue && next.requireValue.isEmpty) {
        _showStartMessage();
      }
    });

    final response = await getChatMessageHistoryUseCase(room.id);
    return response.fold(
      onSuccess: (chatList) => chatList,
      onFailure: (e) {
        /// 실패 아래와 같은 동작을 실행할 수 있음
        /// 1. 파이어베이스 버그 리포트 - SET FIREBASE ANALYTICS LOG
        /// 2. 구조화된 로그 (Presentation, 로깅)
        /// 3. 트스트 Alert 메세지
        log(e.toString());
        ToastService.show(NormalToast(message: '채팅 내역을 불러오지 못하였습니다'));
        throw e;
      },
    );
  }

  /// [messages]를 서버로 업데이트
  Future<void> _updateChat(List<ChatMessageEntity> messages) async {
    await updateChatMessagesUseCase(
      messages: messages,
      chatRoomId: room.id,
    );

    ref.invalidate(interviewRoomsProvider);
  }

  /// 최초 진입시 보여질 메세지
  /// 인사를 호출 한 뒤 바로 질문을 요청한다.
  Future<Stream<String>> _showStartMessage() async {
    final nickname = ref.read(userDataProvider).requireValue!.nickname!;
    final String message = '반가워요! $nickname님. ${room.topic.text} 면접 질문을 드리겠습니다';
    final streamedMessage = message.convertToStreamText;
    final startChat = GuideChatMessageEntity.createStream(
      streamedMessage,
    );
    streamedMessage.listen(
      null,
      onDone: () async {
        streamedMessage.close();

        final qna = ref
            .read(interviewQnAsOfRoomProvider(room).notifier)
            .getFirstNotResponseQna()!;
        final streamedQnaMessage = qna.question.question.convertToStreamText;
        final qnaChat = QuestionChatMessageEntity.createStreamedChat(
          qnaId: qna.id,
          streamedMessage: streamedQnaMessage,
        );
        streamedQnaMessage.listen(
          null,
          onDone: () {
            _updateChat([
              qnaChat,
              startChat,
            ]);
            streamedQnaMessage.close();
          },
        );

        await update(
          (previous) => [
            qnaChat,
            ...previous,
          ],
        );
      },
    );

    await update(
      (previous) => [
        startChat,
        ...previous,
      ],
    );

    return streamedMessage;
  }

  Future<Stream<String>> _showQuestion() async {
    final qna = ref
        .read(interviewQnAsOfRoomProvider(room).notifier)
        .getFirstNotResponseQna()!;
    final streamedChatMessage = qna.question.question.convertToStreamText;
    final chat = QuestionChatMessageEntity.createStreamedChat(
      qnaId: qna.id,
      streamedMessage: streamedChatMessage,
    );
    streamedChatMessage.listen(
      null,
      onDone: () {
        _updateChat([chat]);
        streamedChatMessage.close();
      },
    );

    await update(
      (previous) => [
        chat,
        ...previous,
      ],
    );

    return streamedChatMessage;
  }

  ///
  /// 유저 채팅 응답 추가
  ///
  Future<void> addUserChatResponse(String message) async {
    final answeredQuestion =
        state.requireValue.firstWhere((chat) => chat.type.isAskQuestionMessage)
            as QuestionChatMessageEntity;
    final answerChat = AnswerChatMessageEntity.initial(
      message: message,
      qnaId: answeredQuestion.qnaId,
    );

    await update(
      (previous) => [
        answerChat,
        ...previous,
      ],
    ).then(
      (_) => _respondToUserAnswer(message),
    );
  }

  ///
  /// 유저의 면접 질문 대답에 응답
  /// 정답 여부를 판별하고
  /// 간단한 설명을 덧붙여 피드백을 함.
  ///
  Future<void> _respondToUserAnswer(String userAnswer) async {
    final feedbackMessage = getAnswerFeedBackUseCase.call(
      (
        category: 'Swift',
        checkAnswer: updateUserAnswerState,
        onFeedBackCompleted: onFeedbackCompleted,
        question: state.requireValue
            .firstWhere((chat) => chat.type.isAskQuestionMessage)
            .message
            .value,
        userAnswer: userAnswer,
      ),
    );

    final feedbackChat = FeedbackChatMessageEntity.createStreamChat(
      messageStream: feedbackMessage,
    );
    feedbackMessage.listen(
      null,
      onDone: () {
        _updateChat([feedbackChat]);
      },
    );

    await update(
      (previous) => [
        feedbackChat,
        ...previous,
      ],
    );
  }

  ///
  /// 유저의 답변에 대한 피드백이 완료 되었을 때
  /// 실행되는 메소드
  ///
  void onFeedbackCompleted() {
    final qnas = ref.read(interviewQnAsOfRoomProvider(room)).requireValue;
    final isComplete = qnas.every((element) => element.hasUserResponded);
    final GuideChatMessageEntity chat;
    // 마지막 답변일 경우
    if (isComplete) {
      final interviewClosingText = '면접이 종료 되었습니다'.convertToStreamText;
      chat = GuideChatMessageEntity.createStream(
        interviewClosingText
          ..listen(
            null,
            onDone: interviewClosingText.close,
          ),
      );
    } else {
      final guideStreamedText = '다음 질문을 드리겠습니다'.convertToStreamText;
      chat = GuideChatMessageEntity.createStream(
        guideStreamedText
          ..listen(
            null,
            onDone: () {
              _showQuestion();
              guideStreamedText.close();
            },
          ),
      );
    }

    update(
      (previous) => [
        chat,
        ...previous,
      ],
    );
  }

  ///
  /// 채팅 리스트 유저 답변 정답 체크
  ///
  Future<void> updateUserAnswerState({required bool isCorrect}) async {
    // 1. 채팅 리스트 유저 답변 정답 체크
    final chatList = state.requireValue;

    final answeredChat = chatList.firstWhere((chat) => chat.type.isSentMessage)
        as AnswerChatMessageEntity;
    final resolvedAnsweredChat = answeredChat.copyWith(
      answerState: isCorrect ? AnswerState.correct : AnswerState.wrong,
    );
    final targetIndex = chatList.indexWhere((chat) => chat == answeredChat);

    await update(
      (previous) => [...previous]..[targetIndex] = resolvedAnsweredChat,
    );
    await _updateChat([resolvedAnsweredChat]);
    ref
        .read(interviewQnAsOfRoomProvider(room).notifier)
        .updateQnA(resolvedAnsweredChat);
  }

  ///
  /// 가장 마지막으로 보낸진 [ReceivedChatEntity] 데이터 여부
  /// 하나의 질문 단위로 섹션이 구분
  ///
  /// ex)
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatMessageEntity]
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatMessageEntity] - [ReceivedChatEntity](N) - [ReceivedChatEntity](Y)
  ///
  bool isLastReceivedChatInEachQuestion({required int index}) {
    final chatList = state.requireValue;

    if (index != 0 && state.requireValue[index - 1].type.isSentMessage) {
      return true;
    }

    if (index == 0 && chatList.first.type.isReceivedMessage) {
      return true;
    }

    return false;
  }
}
