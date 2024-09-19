import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/feedback_response_entity.dart';
import 'package:techtalk/features/chat/use_cases/set_ai_follow_up_question_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import 'package:uuid/uuid.dart';

part 'chat_message_history_internal_event.dart';
part 'chat_message_history_provider.g.dart';

@riverpod
class ChatMessageHistory extends _$ChatMessageHistory {
  @override
  FutureOr<List<BaseChatEntity>> build() async {
    final room = ref.read(selectedChatRoomProvider);
    final getChatList = switch (room.progressState) {
      ChatRoomProgress.initial => () async {
          await _showIntroAndQuestionMessages();

          return <BaseChatEntity>[];
        },
      ChatRoomProgress.ongoing || ChatRoomProgress.completed => () async {
          final response = await getChatMessageHistoryUseCase(room.id);
          return response.fold(
            onSuccess: (chatCollection) {
              ref.read(chatQnasProvider.notifier).arrangeQnasInOrder(chatCollection.progressQnaIds);
              return chatCollection.chatHistories;
            },
            onFailure: (e) {
              log(e.toString());

              throw e;
            },
          );
        },
    };

    return getChatList();
  }

  ///
  /// 유저의 채팅 답변 이후 인터뷰 진행 프로세스 단계를 실행시킴
  /// 인터뷰 진행 프로세스는 크게 4가지 프로세스로 구성됨.
  /// 1) 유저의 답변 채팅 메세지 추가
  /// 2) 유저의 답변 정답 여부 확인
  /// 3) 유저 답변에 대한 피드백 채팅 전달
  /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
  ///
  Future<void> proceedInterviewStep(String message) async {
    await _addUserMessage(message).then(handleFeedbackProgress);
  }

  ///
  /// 1) 유저의 답변 채팅 메세지 추가
  ///
  Future<AnswerChatEntity> _addUserMessage(String message) async {
    final answeredQuestion = state.requireValue.firstWhere((chat) => chat is QuestionChatEntity) as QuestionChatEntity;
    final answerChat = AnswerChatEntity.initial(
      message: message,
      qnaId: answeredQuestion.qnaId,
      rootQnaId: answeredQuestion.rootQnaId!,
    );

    await showMessage(
      message: answerChat,
    );

    return answerChat;
  }

  ///
  /// 유저의 면접 질문 대답에 응답.
  /// 아래와 같은 이벤트를 실행시킴
  /// 2) 유저의 답변 정답 여부 확인
  /// 3) 유저 답변에 대한 피드백 채팅 전달
  /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
  ///
  Future<void> handleFeedbackProgress(AnswerChatEntity userAnswer) async {
    late AnswerChatEntity resolvedUserAnswer;
    late bool isAnswerCorrect;

    final room = ref.read(selectedChatRoomProvider);

    final chatHistory =
        [...state.requireValue.where((element) => element.rootQnaId == userAnswer.rootQnaId)].reversed.toList();

    final rootQna = ref.read(chatQnasProvider.notifier).getQnaById(userAnswer.rootQnaId ?? userAnswer.qnaId);

    /*final feedbackChat*/
    final response = getAnswerFeedBackUseCase.call(
      (
        chatHistory: chatHistory,
        qna: rootQna,
        userName: ref.read(userInfoProvider).requireValue!.nickname!,
        checkAnswer: ({required AnswerState answerState}) async {
          /// 만약 정상 작동하지 못했다면
          /// 기존 응답 메세지를 제거하고
          /// 팝업을 노출
          if (answerState == AnswerState.error) {
            await _rollbackToPreviousChatStep();
            final context = rootNavigatorKey.currentContext!;
            DialogService.show(
                dialog: AppDialog.singleBtn(
              btnContent: context.tr(LocaleKeys.common_confirm),
              title: context.tr(LocaleKeys.common_errorDetectedTryLater),
              onBtnClicked: () async {
                context.pop();
                context.pop();
              },
            ));
          } else {
            /// 2) 유저의 답변 정답 여부 확인
            resolvedUserAnswer = await _updateUserAnswerState(answerState: answerState);

            isAnswerCorrect = answerState.isCorrect;
          }
        },
        onFeedBackCompleted: ({required FeedbackResponseEntity feedbackResponse}) async {
          if (kDebugMode) {
            log(
              '\n👀feedback: ${feedbackResponse.feedback}\n👀score: ${feedbackResponse.score}\n👀isFollowUpQuestionNeeded: ${feedbackResponse.isFollowUpQuestionNeeded}\n',
            );
          }

          unawaited(
            FirebaseAnalytics.instance.logEvent(
              name: 'Question Answered',
              parameters: {
                'qna_id': resolvedUserAnswer.qnaId,
                'is_correct': isAnswerCorrect.toString(),
              },
            ),
          );

          /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
          final isCompleted = ref.read(selectedChatRoomProvider.notifier).isLastQuestion();

          late QuestionChatEntity nextQuestionChat;
          late GuideChatEntity guideChat;
          late String guideMessage;
          late ChatQnaEntity newQna;
          late FeedbackChatEntity feedbackChat;

          feedbackChat = FeedbackChatEntity.createStatic(
            message: feedbackResponse.feedback,
            timestamp: DateTime.now(),
            rootQnaId: rootQna.qna.id,
            qnaId: userAnswer.qnaId,
          );

          if (feedbackResponse.isFollowUpQuestionNeeded &&
              chatHistory.whereType<QuestionChatEntity>().length < 2 &&
              !isCompleted) {
            /// NOTE : 순서 주의
            final guideChat = GuideChatEntity.createStatic(
              message: '꼬리 질문입니다.',
              timestamp: DateTime.now(),
            );

            await Future.wait(
              [
                _uploadMessage([
                  resolvedUserAnswer,
                  feedbackChat,
                  guideChat,
                ]),
                showMessage(
                  message: guideChat.overwriteToStream(),
                  onDone: () async {
                    await _startFollowUpQuestion(
                      feedbackResponse: feedbackResponse,
                      chatHistory: chatHistory,
                    );
                  },
                ).then(
                  (_) => ref.read(selectedChatRoomProvider.notifier).updateProgressInfo(
                        isCorrect: isAnswerCorrect,
                        lastChatMessage: guideChat,
                        isRootQuestion: userAnswer.isAnwserForRootQuestion,
                      ),
                ),
              ],
            );

            return;
          }

          if (!isCompleted) {
            newQna = _getNewQna();
            guideMessage = rootNavigatorKey.currentContext!.tr(
              LocaleKeys.undefined_next_question_prompt,
              namedArgs: {
                'topic': room.type.isPractical ? StoredTopics.getById(newQna.qna.id.getFirstPartOfSpliited).text : '',
              },
            );
          } else {
            guideMessage = rootNavigatorKey.currentContext!.tr(LocaleKeys.undefined_interview_ended);
          }

          /// NOTE : 순서 주의
          guideChat = GuideChatEntity.createStatic(
            message: guideMessage,
            timestamp: DateTime.now(),
          );

          if (!isCompleted) {
            nextQuestionChat = QuestionChatEntity.createStatic(
              qnaId: newQna.qna.id,
              rootQnaId: newQna.qna.id,
              message: newQna.qna.question,
              timestamp: DateTime.now(),
            );
          }

          await Future.wait(
            [
              _uploadMessage([
                if (!isCompleted) nextQuestionChat,
                guideChat,
                feedbackChat,
                resolvedUserAnswer,
              ]).then(
                (_) => ref.read(selectedChatRoomProvider.notifier).updateProgressInfo(
                      isCorrect: isAnswerCorrect,
                      lastChatMessage: isCompleted ? guideChat : nextQuestionChat,
                      isRootQuestion: userAnswer.isAnwserForRootQuestion,
                    ),
              ),
              showMessage(
                message: guideChat.overwriteToStream(),
                onDone: () async {
                  if (!isCompleted) {
                    await showMessage(
                      message: nextQuestionChat.overwriteToStream(),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );

    await response.fold(
      onSuccess: (feedbackStreamedChat) async {
        /// 3) 유저 답변에 대한 피드백 채팅 전달
        await showMessage(
          message: FeedbackChatEntity(
            message: feedbackStreamedChat,
            qnaId: rootQna.qna.id,
            rootQnaId: rootQna.qna.id,
          ),
        );
      },
      onFailure: (e) {
        _rollbackToPreviousChatStep();
        SnackBarService.showSnackBar('정답 여부를 판별하는 과정에서 오류가 발생했습니다. 잠시후 다시 시도해주세요.');
      },
    );
  }

  Future<QuestionChatEntity?> _startFollowUpQuestion(
      {required List<BaseChatEntity> chatHistory, required FeedbackResponseEntity feedbackResponse}) async {
    log('👀: 피드백 필요함!!!!!!');

    final followUpQuestionId = const Uuid().v1();

    QuestionChatEntity? followUpQuestionChat;

    final response = SetAiFollowUpQuestionUseCase().call((
      chatHistory: chatHistory,
      onFollowUpQuestionCompleted: ({required String followUpQuestion}) {
        followUpQuestionChat = QuestionChatEntity.createStatic(
          qnaId: followUpQuestionId,
          rootQnaId: feedbackResponse.topicQuestion.qna.id,
          message: followUpQuestion,
          timestamp: DateTime.now(),
        );
        _uploadMessage([
          followUpQuestionChat!,
        ]).then(
          (_) => ref.read(selectedChatRoomProvider.notifier).updateProgressInfo(
                isCorrect: false,
                lastChatMessage: followUpQuestionChat!,
                isRootQuestion: false,
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
        SnackBarService.showSnackBar('정답 여부를 판별하는 과정에서 오류가 발생했습니다. 잠시후 다시 시도해주세요.');
      },
    );

    return followUpQuestionChat;
  }

  ///
  /// 가장 마지막으로 보낸진 [ReceivedChatEntity] 데이터 여부
  /// 하나의 질문 단위로 섹션이 구분
  ///
  /// ex)
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatEntity]
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatEntity] - [ReceivedChatEntity](N) - [ReceivedChatEntity](Y)
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
