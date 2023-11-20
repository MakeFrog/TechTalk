import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/core/utils/route_argument.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/is_available_to_answer.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/total_qna_list_provider.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

part 'chat_messages_provider.g.dart';

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  FutureOr<List<MessageEntity>> build() async {
    ref.onDispose(() {
      ref.invalidate(totalQnaListProvider);
      ref.invalidate(isAvailableToAnswerProvider);
    });

    final routeArg = RouteArg.argument as ChatPageRouteArg;
    final GetChatListParam param = (
      progressState: routeArg.progressState,
      userName: '지혜',
      roomId: routeArg.roomId,
      topic: routeArg.topic
    );

    final response = await getChatMessagesUseCase(param);
    return response.fold(
      onSuccess: (chatList) async {
        // 처음 채팅방에 진입한 경우
        if (routeArg.progressState.isInitial) {
          ref.read(totalQnaListProvider.notifier).initializeQnaList();
          await addRandomQuestionToQnaList();
          chatList.first.message.listen(null, onDone: () {
            showFirstQuestion();
            chatList.first.message.close();
          });
        }
        // 기존 진행중인 채팅방에 진입한 경우
        else {
          ref.read(totalQnaListProvider.notifier).updateQnaListByChat(chatList);
          setChatAvailableState(isAvailable: true);
        }

        unawaited(addRandomQuestionToQnaList());

        return chatList;
      },
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

  ///
  /// 유저 채팅 응답 추가
  ///
  Future<void> addUserChatResponse({required String message}) async {
    final answeredQuestion =
        state.requireValue.lastWhere((chat) => chat.type.isAskQuestionMessage)
            as QuestionMessageEntity;

    await update(
      (previous) => [
        SentMessageEntity.initial(
          message: message,
          questionId: answeredQuestion.questionId,
        ),
        ...previous,
      ],
    );
  }

  ///
  /// 유저의 면접 질문 대답에 응답
  /// 정답 여부를 판별하고
  /// 간단한 설명을 덧붙여 피드백을 함.
  ///
  Future<void> respondToUserAnswer({required String userAnswer}) async {
    await update(
      (previous) => [
        FeedbackMessageEntity.createStreamChat(
          messageStream: getAnswerFeedBackUseCase.call(
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
          ),
        ),
        ...previous
      ],
    );
  }

  ///
  /// 첫 번째 질문 제시
  ///
  Future<void> showFirstQuestion() async {
    final totalQnaList = ref.watch(totalQnaListProvider.notifier);

    final targetQuestion = totalQnaList
        .returnQnaList()
        .firstWhere((qna) => qna.hasUserNotRespondedYet);

    final streamedChatMessage = targetQuestion.question.convertToStreamText;
    streamedChatMessage.listen(null, onDone: () {
      setChatAvailableState(isAvailable: true);
      streamedChatMessage.close();
    });

    await update(
      (previous) => [
        QuestionMessageEntity.createStreamedChat(
          questionId: targetQuestion.id,
          idealAnswers: targetQuestion.idealAnswer,
          streamedMessage: streamedChatMessage,
        ),
        ...previous,
      ],
    );
  }

  ///
  /// 다음 면접 질문 제시
  ///
  Future<void> showNextQuestion() async {
    final preparedQuestionAsync = ref.read(totalQnaListProvider);
    preparedQuestionAsync.map(
      data: (preparedQuestions) {
        final nextQuestion = preparedQuestions.value.last;
        final streamedChatMessage = nextQuestion.question.convertToStreamText;
        streamedChatMessage.listen(null, onDone: () {
          setChatAvailableState(isAvailable: true);
          streamedChatMessage.close();
        });

        update(
          (previous) => [
            QuestionMessageEntity.createStreamedChat(
              streamedMessage: streamedChatMessage,
              questionId: nextQuestion.id,
              idealAnswers: nextQuestion.idealAnswer,
            ),
            ...previous,
          ],
        );

        /// Qna 리스트에 다음 면접 질문 추가
        addRandomQuestionToQnaList();
      },
      error: (e) {
        throw e;
      },
      loading: (_) {},
    );
  }

  ///
  /// 유저의 답변에 대한 피드백이 완료 되었을 때
  /// 실행되는 메소드
  ///
  void onFeedbackCompleted() {
    final guideStreamedText = '다음 질문을 드리겠습니다'.convertToStreamText;
    guideStreamedText.listen(null, onDone: () {
      showNextQuestion();
      guideStreamedText.close();
    });
    update(
      (previous) => [
        GuideMessageEntity.createStream(
          guideStreamedText,
        ),
        ...previous,
      ],
    );
  }

  ///
  /// QnA 리스트 : 새로운 질문 추가
  ///
  Future<void> addRandomQuestionToQnaList() async {
    final response =
        await getRandomInterviewQuestionUseCase.call(InterviewTopic.swift);
    final newQuestion = response.getOrThrow();

    await ref.read(totalQnaListProvider.notifier).addQnaList(newQuestion);
  }

  ///
  /// 1. 채팅 리스트 유저 답변 정답 체크
  /// 2. QnA 리스트 상태 업데이트 (유저 응답)
  /// TODO: 리팩토링 필요
  ///
  Future<void> updateUserAnswerState({required bool isCorrect}) async {
    // 1. 채팅 리스트 유저 답변 정답 체크
    final chatList = state.requireValue;

    final answeredChat = chatList.firstWhere((chat) => chat.type.isSentMessage)
        as SentMessageEntity;

    final targetIndex = chatList.indexWhere((chat) => chat == answeredChat);

    chatList[targetIndex] = answeredChat.copyWith(
        answerState: isCorrect ? AnswerState.correct : AnswerState.wrong);

    await update((_) => chatList);

    // 2. QnA 리스트 상태 업데이트 (유저 응답)
    final updatedSentChat = chatList
        .firstWhere((chat) => chat.type.isSentMessage) as SentMessageEntity;

    final userResponse = UserInterviewResponse(
      updatedSentChat.message.value,
      state: updatedSentChat.answerState,
    );

    await ref
        .read(totalQnaListProvider.notifier)
        .updateUserQnaResponse(userResponse);
  }

  ///
  /// 채팅 가능 여부 state 변경
  ///
  void setChatAvailableState({required bool isAvailable}) {
    ref
        .read(isAvailableToAnswerProvider.notifier)
        .change(isAvailable: isAvailable);
  }

  ///
  /// 가장 마지막으로 보낸진 [ReceivedChatEntity] 데이터 여부
  /// 하나의 질문 단위로 섹션이 구분
  ///
  /// ex)
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [SentMessageEntity]
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [SentMessageEntity] - [ReceivedChatEntity](N) - [ReceivedChatEntity](Y)
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
