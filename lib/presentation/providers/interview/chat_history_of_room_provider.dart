import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/use_cases/update_chat_info_use_case.dart';
import 'package:techtalk/presentation/providers/interview/interview_qnas_of_room_provider.dart';
import 'package:techtalk/presentation/providers/interview/interview_rooms_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_room_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'chat_history_of_room_provider.g.dart';

@riverpod
class ChatHistoryOfRoom extends _$ChatHistoryOfRoom {
  @override
  FutureOr<List<MessageEntity>> build(ChatRoomEntity room) async {
    ref.listenSelf((previous, next) {
      // 처음 채팅방에 진입한 경우
      if (next.hasValue && next.requireValue.isEmpty) {
        _showStartMessage();
      }
    });

    final response = await getChatMessagesUseCase(room.chatRoomId);

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

  ///
  /// 최초 채팅 정보를 서버로 업데이트
  ///
  Future<void> updateInitialChaInfo() async {
    await updateChatInfoUseCase(
      (
        messages: state.requireValue,
        chatRoomId: room.chatRoomId,
      ),
    );
    ref.invalidate(interviewRoomsProvider);
  }

  void _showStartMessage() {
    final nickname = ref.read(userDataProvider).requireValue!.nickname!;
    final String message = '반가워요! $nickname님. ${room.topic.text} 면접 질문을 드리겠습니다';

    final startChat = GuideMessageEntity.createStream(
      message.convertToStreamText,
    )..message.listen(
        null,
        onDone: () {
          showQuestion();
          state.valueOrNull?.first.message.close();
        },
      );

    state.valueOrNull?.add(startChat);
  }

  Future<void> showQuestion() async {
    final qnas = await ref.read(interviewQnAsOfRoomProvider(room).future);
    final targetQuestion = qnas.firstWhere((qna) => !qna.hasUserResponded);
    final streamedChatMessage =
        targetQuestion.question.question.convertToStreamText;
    final chat = QuestionMessageEntity.createStreamedChat(
      questionId: targetQuestion.id,
      idealAnswers: targetQuestion.question.answers,
      streamedMessage: streamedChatMessage
        ..listen(
          null,
          onDone: () {
            updateInitialChaInfo();
            streamedChatMessage.close();
          },
        ),
    );

    await update(
      (previous) => [
        chat,
        ...previous,
      ],
    );
  }

  ///
  /// 유저 채팅 응답 추가
  ///
  Future<void> addUserChatResponse({required String message}) async {
    final answeredQuestion =
        state.requireValue.firstWhere((chat) => chat.type.isAskQuestionMessage)
            as QuestionMessageEntity;
    final answerChat = SentMessageEntity.initial(
      message: message,
      questionId: answeredQuestion.questionId,
    );

    await update(
      (previous) => [
        answerChat,
        ...previous,
      ],
    );
    await updateChat([answerChat]);
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
              qna: state.requireValue
                  .firstWhere((chat) => chat.type.isAskQuestionMessage)
                  .message
                  .value,
              userAnswer: userAnswer,
            ) as GetQuestionFeedbackParam,
          ),
        ),
        ...previous
      ],
    );
  }

  ///
  /// 추가된 채팅 목록을 서버로 업데이트
  ///
  Future<void> updateChat(List<MessageEntity> messages) async {
    final UpdateChatInfoParam param = (
      messages: messages,
      chatRoomId: room.chatRoomId,
    );
    await updateChatInfoUseCase(param);
    ref.invalidate(interviewRoomsProvider);
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
      state: answerState,
      chatRoomId:
          ref.read(selectedInterviewRoomProvider).requireValue.chatRoomId,
      topic: ref.read(selectedInterviewRoomProvider).requireValue.topic,
      interviewer: null,
      progressInfo: null,
    ) as UpdateChatInfoParam;
    await updateChatInfoUseCase.call(param);
    ref.invalidate(interviewRoomsProvider);
  }

  ///
  /// 유저의 답변에 대한 피드백이 완료 되었을 때
  /// 실행되는 메소드
  ///
  void onFeedbackCompleted() {
    final qnas = ref.read(interviewQnAsOfRoomProvider(room)).requireValue;
    final isComplete = qnas.every((element) => element.hasUserResponded);
    final GuideMessageEntity chat;
    // 마지막 답변일 경우
    if (isComplete) {
      final interviewClosingText = '면접이 종료 되었습니다'.convertToStreamText;
      chat = GuideMessageEntity.createStream(
        interviewClosingText
          ..listen(
            null,
            onDone: () {
              updateEndOfChatInfo();
              interviewClosingText.close();
            },
          ),
      );
    } else {
      final guideStreamedText = '다음 질문을 드리겠습니다'.convertToStreamText;
      chat = GuideMessageEntity.createStream(
        guideStreamedText
          ..listen(
            null,
            onDone: () {
              showQuestion();
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

    // await ref
    //     .read(totalQnaListProvider.notifier)
    //     .updateUserQnaResponse(userResponse);
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
