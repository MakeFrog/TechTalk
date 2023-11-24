import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/update_chat_info_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_page_route_argument_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/completed_qna_list_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/total_qna_list_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_provider.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

part 'chat_history_provider.g.dart';

@Riverpod(dependencies: [chatPageRouteArg])
class ChatHistory extends _$ChatHistory {
  @override
  FutureOr<List<MessageEntity>> build() async {
    ref.onDispose(() {
      ref.invalidate(totalQnaListProvider);
    });

    final routeArg = ref.read(chatPageRouteArgProvider);

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
        state.requireValue.firstWhere((chat) => chat.type.isAskQuestionMessage)
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
      updateInitialChaInfo();
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
          updateProgressChatInfo();
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
  /// 추가된 채팅 목록을 서버로 업데이트
  ///
  Future<void> updateProgressChatInfo() async {
    final answerState =
        (state.requireValue.firstWhere((message) => message.type.isSentMessage)
                as SentMessageEntity)
            .answerState;

    final UpdateChatInfoParam param = (
      messages: state.requireValue
          .extractElementsBefore(state.requireValue.firstWhere(
        (message) => message.type.isSentMessage,
      )),
      answerState: answerState,
      chatRoomId: ref.read(chatPageRouteArgProvider).roomId,
      topic: ref.read(chatPageRouteArgProvider).topic,
      qnaProgressInfo: null,
    );
    await updateChatInfoUseCase.call(param);
    ref.read(chatListProvider.notifier).updateChatList();
  }

  ///
  /// 면접이 종료될 때 나머지 채팅 목록을 서버로 업데이트
  ///
  Future<void> updateEndOfChatInfo() async {
    final answerState =
        (state.requireValue.firstWhere((message) => message.type.isSentMessage)
                as SentMessageEntity)
            .answerState;

    final lastMessageIndex = state.requireValue
        .firstIndexWhereOrNull((message) => message.type.isSentMessage);
    final UpdateChatInfoParam param = (
      messages: state.requireValue.sublist(0, lastMessageIndex),
      answerState: answerState,
      chatRoomId: ref.read(chatPageRouteArgProvider).roomId,
      topic: ref.read(chatPageRouteArgProvider).topic,
      qnaProgressInfo: null,
    );
    await updateChatInfoUseCase.call(param);
    ref.read(chatListProvider.notifier).updateChatList();
  }

  ///
  /// 최초 채팅 정보를 서버로 업데이트
  ///
  Future<void> updateInitialChaInfo() async {
    final UpdateChatInfoParam param = (
      messages: state.requireValue,
      answerState: AnswerState.initial,
      chatRoomId: ref.read(chatPageRouteArgProvider).roomId,
      topic: ref.read(chatPageRouteArgProvider).topic,
      qnaProgressInfo: ref.read(chatPageRouteArgProvider).qnaProgressInfo,
    );
    await updateChatInfoUseCase(param);
    ref.read(chatListProvider.notifier).updateChatList();
  }

  ///
  /// 유저의 답변에 대한 피드백이 완료 되었을 때
  /// 실행되는 메소드
  ///
  void onFeedbackCompleted() {
    // 마지막 답변일 경우
    if (ref.read(completedQnAListProvider).requireValue.length >=
        ref.read(chatPageRouteArgProvider).qnaProgressInfo.totalQuestionCount) {
      final interviewClosingText = '면접이 종료 되었습니다'.convertToStreamText;

      update(
        (previous) => [
          GuideMessageEntity.createStream(
            interviewClosingText,
          ),
          ...previous,
        ],
      );
      interviewClosingText.listen(null, onDone: updateEndOfChatInfo);
    } else {
      final guideStreamedText = '다음 질문을 드리겠습니다'.convertToStreamText;
      update(
        (previous) => [
          GuideMessageEntity.createStream(
            guideStreamedText,
          ),
          ...previous,
        ],
      );
      guideStreamedText.listen(
        null,
        onDone: () {
          showNextQuestion();
          guideStreamedText.close();
        },
      );
    }
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
