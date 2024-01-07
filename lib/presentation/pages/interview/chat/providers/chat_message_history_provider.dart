import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_greetings.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
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

  /// [messages]를 서버에 생성
  Future<void> _uploadChat(List<ChatMessageEntity> messages) async {
    await createChatMessagesUseCase(
      messages: messages,
      chatRoomId: room.id,
    );

    ref.invalidate(interviewRoomsProvider);
  }

  /// 최초 진입시 보여질 메세지
  /// 인사 한 뒤 바로 질문을 요청한다.
  Future<void> _showStartMessage() async {
    final nickname = ref.read(userDataProvider).requireValue!.nickname!;
    final topicName = room.topics.first.text +
        (room.topics.length == 1 ? '' : ' 외 ${room.topics.length - 1}');
    final String message =
        '${greetingToInterviewee(nickname)} $topicName 면접 질문을 드리겠습니다';
    final startChat = GuideChatMessageEntity.createStatic(
      message: message,
      timestamp: DateTime.now(),
    );
    final questionChat = ref
        .read(chatQnAsProvider(room).notifier)
        .createQuestionChat(isStream: false);

    await createChatRoomUseCase(
      room: room,
      messages: [startChat, questionChat].reversed.toList(),
      qnas: ref.read(chatQnAsProvider(room)).requireValue,
    );

    await _showMessage(
      message: GuideChatMessageEntity(
        message: message.convertToStreamText,
      ),
      onDone: () async {
        await _showMessage(
          message:
              ref.read(chatQnAsProvider(room).notifier).createQuestionChat(),
        );
      },
    );
  }

  QuestionChatMessageEntity _getLastQuestionChat() {
    return state.requireValue
            .firstWhere((chat) => chat is QuestionChatMessageEntity)
        as QuestionChatMessageEntity;
  }

  ///
  /// 유저 채팅 응답 추가
  ///
  Future<void> addUserChatResponse(String message) async {
    final answeredQuestion = _getLastQuestionChat();
    final answerChat = AnswerChatMessageEntity.initial(
      message: message,
      qnaId: answeredQuestion.qnaId,
    );

    await _showMessage(
      message: answerChat,
      onDone: () {
        _respondToUserAnswer(answerChat);
      },
    );
  }

  ///
  /// 유저의 면접 질문 대답에 응답
  /// 정답 여부를 판별하고
  /// 간단한 설명을 덧붙여 피드백을 함.
  ///
  Future<void> _respondToUserAnswer(AnswerChatMessageEntity userAnswer) async {
    AnswerChatMessageEntity resolvedUserAnswer = userAnswer;
    final feedbackChat = getAnswerFeedBackUseCase.call(
      (
        category: room.topics.first.text,
        checkAnswer: ({required isCorrect}) async {
          resolvedUserAnswer =
              await updateUserAnswerState(isCorrect: isCorrect);
        },
        onFeedBackCompleted: (String feedback) async {
          final qnas = ref.read(chatQnAsProvider(room)).requireValue;
          final isComplete = qnas.every((element) => element.hasUserResponded);
          final String message = isComplete ? '면접이 종료 되었습니다' : '다음 질문을 드리겠습니다';

          await _uploadChat(
            [
              resolvedUserAnswer,
              FeedbackChatMessageEntity.createStatic(
                message: feedback,
                timestamp: DateTime.now(),
              ),
              GuideChatMessageEntity.createStatic(
                message: message,
                timestamp: DateTime.now(),
              ),
              if (!isComplete)
                ref
                    .read(chatQnAsProvider(room).notifier)
                    .createQuestionChat(isStream: false),
            ].reversed.toList(),
          );

          await _showMessage(
            message: GuideChatMessageEntity(
              message: message.convertToStreamText,
            ),
            onDone: () async {
              if (!isComplete) {
                await _showMessage(
                  message: ref
                      .read(chatQnAsProvider(room).notifier)
                      .createQuestionChat(),
                );
              }
            },
          );
        },
        question: state.requireValue
            .firstWhere((chat) => chat.type.isQuestionMessage)
            .message
            .value,
        userAnswer: userAnswer.message.value,
      ),
    );

    final feedback = FeedbackChatMessageEntity(
      message: feedbackChat,
    );
    await _showMessage(message: feedback);
  }

  ///
  /// 채팅 리스트 유저 답변 정답 체크
  ///
  Future<AnswerChatMessageEntity> updateUserAnswerState({
    required bool isCorrect,
  }) async {
    final chatList = state.requireValue.toList();

    final targetIndex = chatList.indexWhere(
      (chat) => chat is AnswerChatMessageEntity,
    );
    final answeredChat =
        chatList.elementAt(targetIndex) as AnswerChatMessageEntity;
    final resolvedAnsweredChat = answeredChat.copyWith(
      answerState: isCorrect ? AnswerState.correct : AnswerState.wrong,
    );
    chatList[targetIndex] = resolvedAnsweredChat;

    await update((previous) => chatList);
    await ref
        .read(chatQnAsProvider(room).notifier)
        .updateState(resolvedAnsweredChat);

    return resolvedAnsweredChat;
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
